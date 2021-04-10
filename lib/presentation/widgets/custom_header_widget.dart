// # Dart Imports
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

/// * Custom Header Widget
/// Header used on the sign in and sign up pages
/// Stateful due to changes in dark and light mode
class CustomHeader extends StatelessWidget {
  CustomHeader({@required this.heading, @required this.subheading});
  final String heading;
  final String subheading;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              '$heading      ',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontSize: sy(23)),
            ),

            // Sub-heading
            Text('$subheading',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: sy(9))),
          ],
        );
      },
    );
  }
}
