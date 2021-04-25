import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_model.dart';
import '../models/user_model.dart';

class EventsRepository {
  CollectionReference _eventsSubCollection;

  EventsRepository(UserModel user) {
    _eventsSubCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("events");
  }

  // # Streams
  Stream<QuerySnapshot> get eventsDataStream {
    return _eventsSubCollection.snapshots().distinct();
  }

  // # Methods
  Future createEventData(Map<String, dynamic> eventData) async {
    await _eventsSubCollection.doc().set(eventData, SetOptions(merge: true));
  }

  Future updateEventData(
      EventModel event, Map<String, dynamic> eventData) async {
    await _eventsSubCollection
        .doc(event.docId)
        .set(eventData, SetOptions(merge: true));
  }
}
