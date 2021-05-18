import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_model.dart';
import '../models/user_model.dart';

class EventRepository {
  EventRepository(UserModel user)
      : _eventsSubCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('events');

  final CollectionReference _eventsSubCollection;

  Stream<List<Event>> get personalEventsStream {
    return _eventsSubCollection
        .snapshots()
        .distinct()
        .map(_mapQuerySnapshotToEvent);
  }

  Future<void> createPersonalEvent(Event event) async {
    _eventsSubCollection.doc().set(event.toMap(), SetOptions(merge: true));
  }

  Future<void> updatePersonalEvent(Event event) async {
    return _eventsSubCollection
        .doc(event.id)
        .set(event.toMap(), SetOptions(merge: true));
  }

  Future<void> deletePersonalEvent(Event event) async {
    return _eventsSubCollection.doc(event.id).delete();
  }

  List<Event> _mapQuerySnapshotToEvent(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Event.fromMap(doc.data()).copyWith(id: doc.id))
        .toList();
  }
}
