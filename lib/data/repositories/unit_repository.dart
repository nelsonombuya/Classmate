import 'package:classmate/data/models/unit_model.dart';
import 'package:classmate/data/repositories/lesson_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnitRepository {
  final DocumentReference _unitDocumentReference;
  final LessonRepository lessonRepository;

  UnitRepository._({
    required LessonRepository lessonRepository,
    required DocumentReference unitDocumentReference,
  })   : lessonRepository = lessonRepository,
        _unitDocumentReference = unitDocumentReference;

  static Future<UnitRepository?> init({
    required String unitId,
    required String schoolId,
    required String sessionId,
  }) async {
    DocumentReference unitDocument = FirebaseFirestore.instance
        .collection('schools')
        .doc(schoolId)
        .collection('sessions')
        .doc(sessionId)
        .collection('units')
        .doc(unitId);

    DocumentSnapshot unitDocumentSnapshot = await unitDocument.get();

    if (unitDocumentSnapshot.data() != null) {
      UnitModel unit = UnitModel.fromMap(unitDocumentSnapshot.data()!)
          .copyWith(id: unitDocumentSnapshot.id);

      LessonRepository lessonRepository = LessonRepository(
        schoolId,
        sessionId,
        unit,
      );

      return UnitRepository._(
        lessonRepository: lessonRepository,
        unitDocumentReference: unitDocument,
      );
    }
  }

  Future<UnitModel> getUnitDetails() {
    return _unitDocumentReference.get().then(_mapDocumentSnapshotToUnitModel);
  }

  UnitModel _mapDocumentSnapshotToUnitModel(DocumentSnapshot snapshot) {
    return UnitModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
