import 'package:flutter/material.dart';

import '../../../../constants/device_query.dart';
import '../../../../constants/route.dart' as route;
import '../../../common_widgets/custom_elevated_button.dart';

class SignUpButton extends StatelessWidget {
  SignUpButton({bool enabled = true}) : _enabled = enabled;

  final bool _enabled;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return Center(
      child: Column(
        children: [
          CustomElevatedButton(
            label: 'Sign Up',
            secondary: true,
            onPressed: _enabled
                ? () => Navigator.of(context).pushNamed(route.signUpPage)
                : null,
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
