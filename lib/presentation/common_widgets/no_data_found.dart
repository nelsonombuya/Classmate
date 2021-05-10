import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key, this.message = "No Data Found"})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

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
          message,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
