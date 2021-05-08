import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data_model.dart';
import '../models/event_model.dart';

class EventRepository {
  final CollectionReference _eventsSubCollection;

  EventRepository(UserModel user)
      : _eventsSubCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('events');

  Stream<List<EventModel>> get personalEventDataStream {
    return _eventsSubCollection
        .orderBy('startDate')
        .snapshots()
        .distinct()
        .map(_mapSnapshotToEventModel);
  }

  Future createEvent(EventModel event) async {
    _eventsSubCollection.doc().set(event.toMap(), SetOptions(merge: true));
  }

  Future updateEvent(EventModel event) async {
    _eventsSubCollection
        .doc(event.docId)
        .set(event.toMap(), SetOptions(merge: true));
  }

  Future deleteEvent(EventModel event) async {
    _eventsSubCollection.doc(event.docId).delete();
  }

  List<EventModel> _mapSnapshotToEventModel(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc) {
        EventModel newEvent = EventModel.fromMap(doc.data());
        return newEvent.copyWith(docId: doc.id);
      },
    ).toList();
  }
}
