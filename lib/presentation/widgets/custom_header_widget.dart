// # Dart Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Custom Header Widget
/// Header used on the sign in and sign up pages
class CustomHeader extends StatelessWidget {
  CustomHeader({@required this.heading, @required this.subheading});
  final String heading;
  final String subheading;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Text('$heading      ',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontSize: Device.height(4.2))),

        // Sub-heading
        Text('$subheading',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontSize: Device.height(1.6))),
      ],
    );
  }
}
