import 'package:classmate/bloc/notification/notification_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);
    NotificationBloc _notifications =
        BlocProvider.of<NotificationBloc>(context);

    return IconButton(
      onPressed: () => _notifications.add(
        SnackBarRequested("WOW", notificationType: NotificationType.Success),
      ),
      icon: Icon(
        Icons.notifications,
        color: CupertinoColors.inactiveGray,
      ),
    );
  }
}
