import 'package:flutter/material.dart';

/// # Create a new account button
/// Button used in the Welcome Page.
/// Goes to the Sign Up Page.
class CreateANewAccountButton extends StatelessWidget {
  CreateANewAccountButton({@required this.buttonColor});
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/sign_up'),
      child: Text(
        'CREATE A NEW ACCOUNT',
        style: Theme.of(context).textTheme.button.copyWith(color: buttonColor),
      ),
    );
  }
}
