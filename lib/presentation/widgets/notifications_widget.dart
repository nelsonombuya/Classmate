// ### Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Notifications Widget
/// Helps with viewing and managing notifications in the app
class NotificationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);
    Color _iconColor =
        Device.brightness == Brightness.light ? Colors.black87 : Colors.white70;

    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.notifications,
        color: _iconColor,
      ),
    );
  }
}
