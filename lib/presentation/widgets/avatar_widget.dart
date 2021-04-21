import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../constants/device.dart';

/// # Avatar Widget
/// Used on the App Bar to allow the user to perform various account functions
class Avatar extends StatelessWidget {
  Avatar({this.image, this.initials, @required this.authBloc});
  final ImageProvider image;
  final AuthBloc authBloc; // Used for Signing Out
  final String initials;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return IconButton(
      onPressed: () => showAlertDialog(context),
      icon: CircleAvatar(
        backgroundColor: image != null ? null : Colors.white70,
        child: image != null ? null : Text(initials),
        backgroundImage: image,
      ),
    );
  }

  showAlertDialog(BuildContext context) {
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
          color: Colors.white,
          fontFamily: "Averta",
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.headline6,
      contentTextStyle:
          Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
      actions: [cancelButton, signOutButton],
      backgroundColor: Colors.black54,
      title: Text(
        "SIGN OUT",
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Are you sure you want to sign out?",
        textAlign: TextAlign.center,
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
