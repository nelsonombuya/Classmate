import 'package:flutter/material.dart';

import '../../../constants/device.dart';
import '../../../constants/routes.dart';
import 'custom_elevatedButton_widget.dart';

class SignUpButton extends StatelessWidget {
  final bool enabled;

  SignUpButton({@required this.enabled});

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
