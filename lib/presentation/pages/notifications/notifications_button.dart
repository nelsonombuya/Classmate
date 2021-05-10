import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'notifications.dart';

class NotificationsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Show Notifications',
      onPressed: () => showBarModalBottomSheet(
        context: context,
        builder: (context) => NotificationsForm(),
      ),
      icon: Icon(
        Icons.notifications_none_rounded,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}
