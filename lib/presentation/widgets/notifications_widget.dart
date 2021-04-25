// ### Imports
import 'package:classmate/bloc/notifications/notifications_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// # Notifications Widget
/// Helps with viewing and managing notifications in the app
class NotificationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);
    NotificationsBloc _notifications =
        BlocProvider.of<NotificationsBloc>(context);

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
