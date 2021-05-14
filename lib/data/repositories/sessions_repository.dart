import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/school_model.dart';
import '../models/session_model.dart';

class SessionRepository {
  SessionRepository(SchoolModel school)
      : _sessionSubCollection = FirebaseFirestore.instance
            .collection('schools')
            .doc(school.id)
            .collection('sessions');

  final CollectionReference _sessionSubCollection;

  Future<List<SessionModel>> getAllSessions() {
    return _sessionSubCollection
        .get()
        .then((snapshot) => _mapQuerySnapshotToSessionModelList(snapshot));
  }

  Future<SessionModel> getSessionDetails(SessionModel session) {
    return _sessionSubCollection
        .doc(session.id)
        .get()
        .then(_mapQuerySnapshotToSessionModel);
  }

  Future<SessionModel> getSessionDetailsFromID(String sessionID) {
    return _sessionSubCollection
        .doc(sessionID)
        .get()
        .then(_mapQuerySnapshotToSessionModel);
  }

  // ### Mappers
  List<SessionModel> _mapQuerySnapshotToSessionModelList(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SessionModel.fromMap(doc.data()).copyWith(id: doc.id);
    }).toList();
  }

  SessionModel _mapQuerySnapshotToSessionModel(DocumentSnapshot snapshot) {
    return SessionModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
  }
}
