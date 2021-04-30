import 'package:flutter/material.dart';

import '../../../common_widgets/secondary_elevated_button.dart';

class SignInButton extends StatelessWidget {
  final void Function()? onPressed;

  const SignInButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomElevatedButton(
        onPressed: onPressed,
        child: Text(
          'Sign In',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
