import 'package:flutter/material.dart';

import '../../../../constants/device_query.dart';

class DividerWithWordAtCenter extends StatelessWidget {
  final String text;

  DividerWithWordAtCenter({required this.text});

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final double _spaceAroundWord = _deviceQuery.safeWidth(2.5);
    final double _dividerThickness = _deviceQuery.safeHeight(0.15);

    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: _dividerThickness,
            color: Theme.of(context).dividerColor,
          ),
        ),
        VerticalDivider(width: _spaceAroundWord),
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
  }
}
