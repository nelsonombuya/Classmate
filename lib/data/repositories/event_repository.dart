import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_model.dart';
import '../models/user_model.dart';

class EventRepository {
  final CollectionReference _eventsSubCollection;

  EventRepository(UserModel user)
      : _eventsSubCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('events');

  Stream<List<EventModel>> get eventsDataStream {
    return _eventsSubCollection
        .snapshots()
        .distinct()
        .map(_mapSnapshotToEventModel);
  }

  Future createEvent(Map<String, dynamic> eventData) async {
    await _eventsSubCollection.doc().set(eventData, SetOptions(merge: true));
  }

  Future updateEvent(EventModel event, Map<String, dynamic> eventData) async {
    await _eventsSubCollection
        .doc(event.docId)
        .set(eventData, SetOptions(merge: true));
  }

  List<EventModel> _mapSnapshotToEventModel(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => EventModel(
            docId: '', // TODO Find way to add docID
            title: doc.data()['title'] ?? '',
            description: doc.data()['description'] ?? '',
            startingDate: doc.data()['starting_date'] ?? null,
            endingDate: doc.data()['ending_date'] ?? null,
          ),
        )
        .toList();
  }
}
