import '../models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnitRepository {
  UnitRepository({required String schoolID, required String sessionID})
      : _unitsSubCollection = FirebaseFirestore.instance
            .collection('schools')
            .doc(schoolID)
            .collection('sessions')
            .doc(sessionID)
            .collection('units');

  final CollectionReference _unitsSubCollection;

  Future<Unit?> getUnit(String unitId) async {
    return _unitsSubCollection
        .doc(unitId)
        .get()
        .then(_mapDocumentSnapshotToUnit);
  }

  Future<void> updateUnit(Unit unit) async {
    _unitsSubCollection.doc(unit.id).set(unit.toMap(), SetOptions(merge: true));
  }

  Stream<Unit?> getUnitsStream(String unitId) {
    return _unitsSubCollection
        .doc(unitId)
        .snapshots()
        .map(_mapDocumentSnapshotToUnit);
  }

  Unit? _mapDocumentSnapshotToUnit(DocumentSnapshot snapshot) {
    return snapshot.data() == null
        ? null
        : Unit.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
