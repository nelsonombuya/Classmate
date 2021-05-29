import 'package:classmate/data/models/message_model.dart';
import 'package:classmate/presentation/common_widgets/form_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NotificationsForm extends StatefulWidget {
  @override
  _NotificationsFormState createState() => _NotificationsFormState();
}

class _NotificationsFormState extends State<NotificationsForm> {
  List<NotificationMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _getDeviceToken();
    _configureListeners();
  }

  _addMessageToList(RemoteMessage message) =>
      setState(() => _messages.add(_mapMessageToModel(message)));

  Widget _buildNotificationsListView(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          _messages[index].title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  _configureListeners() {
    FirebaseMessaging.onMessage.listen(_addMessageToList);
    FirebaseMessaging.onMessageOpenedApp.listen(_addMessageToList);
  }

  _getDeviceToken() => FirebaseMessaging.instance.getToken().then(Logger().d);

  _mapMessageToModel(RemoteMessage message) {
    Map<String, dynamic> newMessage = message.data.isNotEmpty
        ? message.data
        : {
            'title': message.notification?.title,
            'body': message.notification?.body,
          };

    return NotificationMessage.fromMap(newMessage);
  }

  @override
  Widget build(BuildContext context) {
    return FormView(
      title: 'Notifications',
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _messages.length,
        itemBuilder: _buildNotificationsListView,
      ),
    );
  }
}
