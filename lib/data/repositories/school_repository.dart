import '../models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolRepository {
  SchoolRepository()
      : _schoolsCollection = FirebaseFirestore.instance.collection('schools');

  final CollectionReference _schoolsCollection;

  Future<List<SchoolModel>> getAllSchools() {
    return _schoolsCollection.get().then(_mapQuerySnapshotToSchoolModelList);
  }

  Future<SchoolModel> getSchoolDetailsFromID(String schoolID) {
    return _schoolsCollection
        .doc(schoolID)
        .get()
        .then(_mapDocumentSnapshotToSchoolModel);
  }

  List<SchoolModel> _mapQuerySnapshotToSchoolModelList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => SchoolModel.fromMap(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  SchoolModel _mapDocumentSnapshotToSchoolModel(DocumentSnapshot snapshot) {
    return SchoolModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
