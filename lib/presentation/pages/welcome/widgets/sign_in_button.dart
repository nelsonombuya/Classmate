import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/device_query.dart';
import '../../../../constants/route.dart' as route;

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: _deviceQuery.safeWidth(64.0),
        height: _deviceQuery.safeHeight(6.2),
      ),
      child: ElevatedButton(
        child: Text('SIGN IN'),
        onPressed: () => Navigator.of(context).pushNamed(route.signInPage),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
