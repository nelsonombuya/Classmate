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

  Stream<List<EventModel>> get personalEventDataStream {
    return _eventsSubCollection
        .snapshots()
        .distinct()
        .map(_mapQuerySnapshotToEventModel);
  }

  Future<void> createPersonalEvent(EventModel event) async {
    _eventsSubCollection.doc().set(event.toMap(), SetOptions(merge: true));
  }

  Future<void> updatePersonalEvent(EventModel event) async {
    return _eventsSubCollection
        .doc(event.id)
        .set(event.toMap(), SetOptions(merge: true));
  }

  Future<void> deletePersonalEvent(EventModel event) async {
    return _eventsSubCollection.doc(event.id).delete();
  }

  List<EventModel> _mapQuerySnapshotToEventModel(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => EventModel.fromMap(doc.data()).copyWith(id: doc.id))
        .toList();
  }
}
