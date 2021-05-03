import 'package:cloud_firestore/cloud_firestore.dart';

class SessionRepository {
  final DocumentReference unit;
  final String session;

  const SessionRepository(this.unit, this.session);

  Stream<DocumentSnapshot> get sessionDataStream {
    return unit.collection('sessions').doc(session).snapshots().distinct();
  }
}
