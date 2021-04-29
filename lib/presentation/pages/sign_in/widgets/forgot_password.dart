import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final bool enabled;
  final void Function()? onPressed;

  ForgotPasswordWidget({this.enabled = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: enabled ? onPressed : null,
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
