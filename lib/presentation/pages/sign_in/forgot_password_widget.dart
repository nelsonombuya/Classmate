// # Imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// # Forgot Password Widget
/// Used on the sign in page to transition to the Forgot Password page.
class ForgotPasswordWidget extends StatelessWidget {
  ForgotPasswordWidget({@required this.enabled});
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: enabled ? () {} : null,
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }
}
