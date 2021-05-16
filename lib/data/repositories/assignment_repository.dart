import 'package:classmate/data/models/assignment_model.dart';

import 'package:classmate/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentRepository {
  final CollectionReference _assignmentsSubCollection;
  final String schoolId;
  final String sessionId;
  final UnitModel unit;

  AssignmentRepository(this.schoolId, this.sessionId, this.unit)
      : _assignmentsSubCollection = FirebaseFirestore.instance
            .collection('schools')
            .doc(schoolId)
            .collection('sessions')
            .doc(sessionId)
            .collection('units')
            .doc(unit.id)
            .collection('assignments');

  Stream<List<AssignmentModel>> get assignmentsDataStream {
    return _assignmentsSubCollection
        .snapshots()
        .distinct()
        .map(_mapQuerySnapshotToAssignmentModelList);
  }

  List<AssignmentModel> _mapQuerySnapshotToAssignmentModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => AssignmentModel.fromMap(doc.data())
            .copyWith(id: doc.id, unit: unit))
        .toList();
  }
}
