import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../constants/device.dart';

/// # Avatar Widget
/// Used on the App Bar to allow the user to perform various account functions
class Avatar extends StatelessWidget {
  Avatar({this.image, this.displayName, @required this.authBloc});
  final ImageProvider image;
  final String displayName;
  final AuthBloc authBloc; // * Used for Signing Out

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showAlertDialog(context),
      icon: CircleAvatar(
        backgroundColor: image != null ? null : Colors.white70,
        child: image != null ? null : Text(displayName ?? "N/A"),
        backgroundImage: image,
        radius: 16.0,
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    Device().init(context);

    Widget signOutButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        authBloc.add(AuthRemoved());
      },
      child: Text(
        "SIGN OUT",
        style: TextStyle(
          color: Colors.red,
          fontFamily: "Averta",
        ),
      ),
    );

    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        "CANCEL",
        style: TextStyle(
          fontFamily: "Averta",
          color: Device.brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      title: Text("SIGN OUT"),
      actions: [cancelButton, signOutButton],
      content: Text("Are you sure you want to sign out?"),
      backgroundColor: Device.brightness == Brightness.light
          ? Colors.white.withOpacity(0.9)
          : Colors.black.withOpacity(0.9),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
