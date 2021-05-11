import 'package:classmate/data/models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolRepository {
  SchoolRepository()
      : _schoolsCollection = FirebaseFirestore.instance.collection('schools');

  final CollectionReference _schoolsCollection;

  Future<List<SchoolModel>> getAllSchools() async {
    return _schoolsCollection
        .get()
        .then((snapshot) => _mapQuerySnapshotToSchoolModelList(snapshot));
  }

  // ### Mappers
  List<SchoolModel> _mapQuerySnapshotToSchoolModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SchoolModel.fromMap(doc.data()).copyWith(id: doc.id);
    }).toList();
  }
}
