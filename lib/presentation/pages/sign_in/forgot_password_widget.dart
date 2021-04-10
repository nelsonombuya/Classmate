// # Imports
import 'package:flutter/material.dart';

/// # Forgot Password Widget
/// Used on the sign in page to transition to the Forgot Password page.
class ForgotPasswordWidget extends StatelessWidget {
  ForgotPasswordWidget({@required this.areThingsEnabled});
  final bool areThingsEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: areThingsEnabled ? () {} : null,
          child: Text('Forgot Password?'),
        ),
      ],
    );
  }
}
