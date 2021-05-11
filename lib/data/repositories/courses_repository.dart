import 'package:classmate/data/models/course_model.dart';
import 'package:classmate/data/models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRepository {
  CourseRepository(SchoolModel school)
      : _courseSubCollection = FirebaseFirestore.instance
            .collection('schools')
            .doc(school.id)
            .collection('courses');

  final CollectionReference _courseSubCollection;

  Future<List<CourseModel>> getAllCourses() {
    return _courseSubCollection
        .get()
        .then((snapshot) => _mapQuerySnapshotToCourseModelList(snapshot));
  }

  Future<CourseModel> getCourseDetails(CourseModel course) {
    return _courseSubCollection
        .doc(course.id)
        .get()
        .then(_mapQuerySnapshotToCourseModel);
  }

  // ### Mappers
  List<CourseModel> _mapQuerySnapshotToCourseModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CourseModel.fromMap(doc.data()).copyWith(id: doc.id);
    }).toList();
  }

  CourseModel _mapQuerySnapshotToCourseModel(DocumentSnapshot snapshot) {
    return CourseModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
