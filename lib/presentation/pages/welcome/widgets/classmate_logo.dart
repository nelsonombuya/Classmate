import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/device_query.dart';

class ClassMateLogo extends StatelessWidget {
  late final DeviceQuery _deviceQuery;
  late final TextStyle _logoTextStyle;

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);
    _logoTextStyle = Theme.of(context).textTheme.headline2 == null
        // TODO Implement Error Handler ❗
        ? throw Exception('Logo text style should not be null. ❗')
        : Theme.of(context).textTheme.headline2!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _deviceQuery.safeWidth(26.0),
          height: _deviceQuery.safeWidth(26.0),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/logo/white_plain.png',
            fit: BoxFit.contain,
          ),
        ),
        Row(
          children: [
            Text(
              "Class",
              textAlign: TextAlign.left,
              style: _logoTextStyle.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: _deviceQuery.safeHeight(7.0),
                color: Theme.of(context).backgroundColor,
              ),
            ),
            Text(
              "Mate",
              textAlign: TextAlign.left,
              style: _logoTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: _deviceQuery.safeHeight(7.0),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
