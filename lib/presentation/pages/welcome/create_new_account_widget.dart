// # Imports
import 'package:classmate/constants/routes.dart';
import 'package:flutter/material.dart';

/// # Create a new account button
/// Button used in the Welcome Page.
/// Goes to the Sign Up Page.
class CreateANewAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Routes.sailor('/sign_up'),
      child: Text(
        'CREATE A NEW ACCOUNT',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
    );
  }
}
