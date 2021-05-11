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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: _deviceQuery.safeHeight(3.0)),
        Text(
          "¯\\_( ͡° ͜ʖ ͡°)_/¯",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontFamily: "Noto"),
        ),
        SizedBox(height: _deviceQuery.safeHeight(3.0)),
        Text(
          _message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
