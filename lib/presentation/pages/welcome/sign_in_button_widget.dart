// # Imports
import 'package:classmate/constants/device.dart';
import 'package:classmate/constants/routes.dart';
import 'package:flutter/material.dart';

/// # Sign In With Email
/// Button for signing in with e-mail address on Welcome Page.
/// Sends the user to the sign in page.
class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: Device.width(64.0),
        height: Device.height(6.2),
      ),
      child: ElevatedButton(
        onPressed: () => Routes.sailor('/sign_in'),
        child: Text(
          'SIGN IN',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
