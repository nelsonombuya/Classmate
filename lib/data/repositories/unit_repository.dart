import 'package:classmate/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnitRepository {
  final DocumentReference _unitDocumentReference;

  UnitRepository({
    required String unitId,
    required String schoolId,
    required String sessionId,
  }) : _unitDocumentReference = FirebaseFirestore.instance
            .collection('schools')
            .doc(schoolId)
            .collection('sessions')
            .doc(sessionId)
            .collection('units')
            .doc(unitId);

  Future<UnitModel> getUnitDetails() {
    return _unitDocumentReference.get().then(_mapDocumentSnapshotToUnitModel);
  }

  UnitModel _mapDocumentSnapshotToUnitModel(DocumentSnapshot snapshot) {
    return snapshot.data() == null
        ? UnitModel(id: snapshot.id)
        : UnitModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
