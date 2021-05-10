import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final bool _enabled;
  final void Function()? _onPressed;

  ForgotPasswordButton({bool enabled = true, void Function()? onPressed})
      : _enabled = enabled,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: _enabled ? _onPressed : null,
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
