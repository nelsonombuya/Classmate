// # Imports
import 'package:flutter/material.dart';

/// # Sign In With Email
/// Button for signing in with e-mail address on Welcome Page.
/// Sends the user to the sign in page.
class SignInWithEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 250, height: 50),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/sign_in'),
        child: Text(
          'SIGN IN WITH E-MAIL',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
