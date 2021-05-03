import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRepository {
  // late final DocumentReference _courseDocument;
  late final CollectionReference _coursesCollection;

  CourseRepository() {
    _coursesCollection = FirebaseFirestore.instance.collection('courses');
  }

  Stream<QuerySnapshot> get coursesDataStream {
    return _coursesCollection.snapshots().distinct();
  }
}
