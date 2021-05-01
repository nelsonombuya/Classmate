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

  Stream<List<EventModel>> get eventDataStream {
    return _eventsSubCollection
        .snapshots()
        .distinct()
        .map(_mapSnapshotToEventModel);
  }

  Future createEvent(Map<String, dynamic> eventData) async {
    _eventsSubCollection.doc().set(eventData, SetOptions(merge: true));
  }

  Future updateEvent(EventModel event, Map<String, dynamic> eventData) async {
    _eventsSubCollection
        .doc(event.docId)
        .set(eventData, SetOptions(merge: true));
  }

  List<EventModel> _mapSnapshotToEventModel(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => EventModel(
            docId: '',
            title: doc.data()['title'],
            description: doc.data()['description'],
            startingDate: DateTime.fromMillisecondsSinceEpoch(
              doc.data()['start_date'],
            ),
            endingDate: DateTime.fromMillisecondsSinceEpoch(
              doc.data()['end_date'],
            ),
          ),
        )
        .toList();
  }
}
