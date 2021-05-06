import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class SessionRepository {
  final DocumentReference unit;
  final String session;

  const SessionRepository(this.unit, this.session);

  Stream<DocumentSnapshot> get sessionDataStream {
    return unit.collection('sessions').doc(session).snapshots().distinct();
  }

  Stream<QuerySnapshot> get assignmentsDataStream {
    return unit
        .collection('sessions')
        .doc(session)
        .collection('assignments')
        .snapshots()
        .distinct();
  }

  updateAssignmentForUser({
    required UserModel user,
    required String assignmentID,
    required Map<String, dynamic> userData,
  }) {
    return unit
        .collection('sessions')
        .doc(session)
        .collection('assignments')
        .doc(assignmentID)
        .update(userData);
  }
}
