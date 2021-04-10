// # Imports
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

/// # Sign In With Email
/// Button for signing in with e-mail address on Welcome Page.
/// Sends the user to the sign in page.
class SignInWithEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: sx(340), height: sy(32)),
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/sign_in'),
            child: Text(
              'Sign In With E-Mail',
              style:
                  Theme.of(context).textTheme.button.copyWith(fontSize: sy(9)),
            ),
          ),
        );
      },
    );
  }
}
