import 'package:flutter/material.dart';

import '../../../../constants/device_query.dart';

enum Position { left, center }

class DividerWithText extends StatelessWidget {
  const DividerWithText(
    this.text, {
    this.position = Position.center,
  });

  final String text;
  final Position position;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final double _spaceAroundWord = _deviceQuery.safeWidth(2.5);
    final double _dividerThickness = _deviceQuery.safeHeight(0.15);

    switch (position) {
      case Position.left:
        return Row(
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Theme.of(context).dividerColor),
            ),
            VerticalDivider(width: _spaceAroundWord),
            Expanded(
              child: Divider(
                thickness: _dividerThickness,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ],
        );
      default:
        return Row(
          children: [
            Expanded(
              child: Divider(
                thickness: _dividerThickness,
                color: Theme.of(context).dividerColor,
              ),
            ),
            VerticalDivider(width: _spaceAroundWord),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).dividerColor),
              ),
            ),
            VerticalDivider(width: _spaceAroundWord),
            Expanded(
              child: Divider(
                thickness: _dividerThickness,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ],
        );
    }
  }
}
