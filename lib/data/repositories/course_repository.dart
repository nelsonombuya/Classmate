import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRepository {
  late final CollectionReference _coursesCollection;

  CourseRepository() {
    _coursesCollection = FirebaseFirestore.instance.collection('courses');
  }

  Stream<QuerySnapshot> get coursesDataStream {
    return _coursesCollection.snapshots().distinct();
  }

  Future<QuerySnapshot> getAllCourseDetails() {
    return _coursesCollection.get();
  }

  late final DocumentReference _courseDocument;
  CourseRepository.course(DocumentReference courseDocumentPath)
      : _courseDocument =
            FirebaseFirestore.instance.doc(courseDocumentPath.toString());

  Future<DocumentSnapshot> getCourseDetails() {
    return _courseDocument.get();
  }
}
