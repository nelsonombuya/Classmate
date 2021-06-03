import '../models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepository {
  MessageRepository()
      : _messageCollection = FirebaseFirestore.instance.collection('messages');

  final CollectionReference _messageCollection;

  Future<void> createMessage(NotificationMessage message) async {
    return _messageCollection
        .doc()
        .set(message.toMap(), SetOptions(merge: true));
  }
}
