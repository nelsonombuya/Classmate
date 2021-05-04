import 'package:cloud_firestore/cloud_firestore.dart';

class UnitRepository {
  late final CollectionReference _unitsCollectionReference;

  UnitRepository()
      : _unitsCollectionReference =
            FirebaseFirestore.instance.collection('units');

  Stream<QuerySnapshot> get unitsStream {
    return _unitsCollectionReference.snapshots().distinct();
  }

  Future<DocumentSnapshot> getUnitDetails(DocumentReference unit) {
    return unit.get();
  }
}
