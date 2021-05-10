import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key, String message = "No Data Found"})
      : _message = message,
        super(key: key);

  final String _message;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¯\\_( ͡° ͜ʖ ͡°)_/¯",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontFamily: "Noto"),
        ),
        SizedBox(
          height: _deviceQuery.safeHeight(2.0),
        ),
        Text(
          _message,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
