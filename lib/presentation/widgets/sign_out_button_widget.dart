import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../constants/device.dart';

/// # Sign Out Widget
/// Used to allow the user to sign out
class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SignOutButtonWidget(),
    );
  }
}

class SignOutButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthBloc _auth = BlocProvider.of<AuthBloc>(context);
    Device().init(context);

    return IconButton(
      onPressed: () => _showAlertDialog(context, _auth),
      icon: Icon(
        Icons.logout,
        color: Device.brightness == Brightness.light
            ? Colors.black87
            : Colors.white70,
      ),
    );
  }

  _showAlertDialog(BuildContext context, authBloc) {
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
