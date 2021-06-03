import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../data/models/message_model.dart';
import '../../common_widgets/form_view.dart';

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
        child: ListTile(
          title: Text(
            _messages[index].title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(_messages[index].body),
        ),
      ),
    );
  }

  _goToNotificationsPage(RemoteMessage message) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => NotificationsForm(),
    );
    _addMessageToList(message);
  }

  _configureListeners() {
    FirebaseMessaging.onMessage.listen(_addMessageToList);
    FirebaseMessaging.onMessageOpenedApp.listen(_goToNotificationsPage);
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
