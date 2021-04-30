import 'package:flutter/material.dart';

import '../../../../constants/device_query.dart';
import '../../../../constants/route.dart' as route;
import '../../../common_widgets/secondary_elevated_button.dart';

class SignUpButton extends StatelessWidget {
  final bool enabled;

  SignUpButton({this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    return Center(
      child: Column(
        children: [
          CustomElevatedButton(
            secondary: true,
            onPressed: enabled
                ? () => Navigator.of(context).pushNamed(route.signUpPage)
                : null,
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          SizedBox(height: _deviceQuery.safeHeight(3)),
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
