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
        .orderBy('startDate')
        .snapshots()
        .distinct()
        .map(_mapSnapshotToEventModel);
  }

  Future createPersonalEvent(EventModel event) async {
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

  // ### Mappers
  List<EventModel> _mapSnapshotToEventModel(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc) {
        EventModel newEvent = EventModel.fromMap(doc.data());
        return newEvent.copyWith(id: doc.id);
      },
    ).toList();
  }
}
