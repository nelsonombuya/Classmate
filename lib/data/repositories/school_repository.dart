import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/school_model.dart';

class SchoolRepository {
  SchoolRepository()
      : _schoolsCollection = FirebaseFirestore.instance.collection('schools');

  final CollectionReference _schoolsCollection;

  Future<List<School>> getAllSchools() {
    return _schoolsCollection.get().then(_mapQuerySnapshotToSchoolList);
  }

  Future<School> getSchoolDetailsFromID(String schoolID) {
    return _schoolsCollection
        .doc(schoolID)
        .get()
        .then(_mapDocumentSnapshotToSchool);
  }

  Future<void> createSchool(School school) async {
    return _schoolsCollection
        .doc()
        .set(school.toMap(), SetOptions(merge: true));
  }

  Future<void> updateSchool(School school) async {
    _schoolsCollection
        .doc(school.id)
        .set(school.toMap(), SetOptions(merge: true));
  }

  List<School> _mapQuerySnapshotToSchoolList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => School.fromMap(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  School _mapDocumentSnapshotToSchool(DocumentSnapshot snapshot) {
    return School.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
