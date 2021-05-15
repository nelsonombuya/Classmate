import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonRepository {
  final CollectionReference _lessonsSubCollection;
  final String schoolId;
  final String sessionId;
  final UnitModel unit;

  LessonRepository(this.schoolId, this.sessionId, this.unit)
      : _lessonsSubCollection = FirebaseFirestore.instance
            .collection('schools')
            .doc(schoolId)
            .collection('sessions')
            .doc(sessionId)
            .collection('units')
            .doc(unit.id)
            .collection('lessons');

  Stream<List<LessonModel>> get lessonsDataStream {
    return _lessonsSubCollection
        .orderBy('startDate')
        .snapshots()
        .distinct()
        .map(_mapQuerySnapshotToLessonModelList);
  }

  List<LessonModel> _mapQuerySnapshotToLessonModelList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) =>
            LessonModel.fromMap(doc.data()).copyWith(id: doc.id, unit: unit))
        .toList();
  }
}
