import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

/// # Create a new account button
/// Button used in the Welcome Page.
/// Goes to the Sign Up Page.
class CreateANewAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return TextButton(
          onPressed: () => Navigator.pushNamed(context, '/sign_up'),
          child: Text(
            'CREATE A NEW ACCOUNT',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white, fontSize: sy(9)),
          ),
        );
      },
    );
  }
}
