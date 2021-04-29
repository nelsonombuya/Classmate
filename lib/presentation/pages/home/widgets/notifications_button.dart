import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../bloc/notification/notification_bloc.dart';
import '../forms/notifications.dart';

class NotificationsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationBloc _notifications =
        BlocProvider.of<NotificationBloc>(context);

    return IconButton(
      tooltip: 'Show Notifications',
      onPressed: () {
        _notifications.add(
          // TODO Remove later (Used for Testing)
          SnackBarRequested("You have no new notifications"),
        );
        showBarModalBottomSheet(
          context: context,
          builder: (context) => NotificationsForm(),
        );
      },
      icon: Icon(
        Icons.notifications_none_rounded,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}
