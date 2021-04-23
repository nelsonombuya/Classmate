import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../constants/device.dart';
import '../../constants/enums.dart';
import 'dialog_widget.dart';

/// # Sign Out Widget
/// Used to allow the user to sign out
class SignOutButton extends StatelessWidget {
  _showSignOutDialog(BuildContext context, AuthBloc authBloc) {
    CustomDialog(
      context,
      title: "Sign Out",
      type: NotificationType.Danger,
      positiveActionLabel: "SIGN OUT",
      positiveActionIcon: Icons.logout,
      description: "Are you sure you want to sign out?",
      descriptionIcon: Icons.warning_amber_rounded,
      positiveActionOnPressed: () {
        Navigator.of(context).pop();
        authBloc.add(AuthRemoved());
      },
      negativeActionLabel: "CANCEL",
      negativeActionOnPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc _auth = BlocProvider.of<AuthBloc>(context);
    Device().init(context);

    return IconButton(
      onPressed: () => _showSignOutDialog(context, _auth),
      icon: Icon(
        Icons.logout,
        color: Device.brightness == Brightness.light
            ? Colors.black87
            : Colors.white70,
      ),
    );
  }
}
