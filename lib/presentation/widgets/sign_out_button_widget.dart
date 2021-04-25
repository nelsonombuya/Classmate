import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/notifications/notifications_bloc.dart';
import '../../constants/device.dart';

/// # Sign Out Widget
/// Used to allow the user to sign out
class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);
    NotificationsBloc _notifications =
        BlocProvider.of<NotificationsBloc>(context);

    return IconButton(
      onPressed: () => _notifications.add(SignOutDialogBoxRequested(context)),
      icon: Icon(
        Icons.logout,
        color: Device.brightness == Brightness.light
            ? Colors.black87
            : Colors.white70,
      ),
    );
  }
}
