// # Imports
import 'package:classmate/presentation/pages/sign_in/custom_elevatedButton_widget.dart';
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Sign Up Button
/// Used on the Sign In Page to transition to the Sign Up Page.
/// It's accompanied by a caption below it.
class SignUpButton extends StatelessWidget {
  SignUpButton({@required this.enabled});
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Center(
      child: Column(
        children: [
          CustomElevatedButton(
            onPressed: enabled ? () => Routes.sailor('/sign_up') : null,
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          SizedBox(height: Device.height(3)),
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
