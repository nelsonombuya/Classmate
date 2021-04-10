// # Imports
import 'package:classmate/presentation/widgets/custom_elevatedButton_widget.dart';
import 'package:flutter/material.dart';

/// # Sign Up Button
/// Used on the Sign In Page to transition to the Sign Up Page.
/// It's accompanied by a caption below it.
class SignUpButton extends StatelessWidget {
  SignUpButton({@required this.areThingsEnabled});
  final bool areThingsEnabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomElevatedButton(
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: areThingsEnabled
                ? () => Navigator.pushNamed(context, '/sign_up')
                : null,
          ),
          SizedBox(height: 20),
          Text(
            'To create a new account.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
