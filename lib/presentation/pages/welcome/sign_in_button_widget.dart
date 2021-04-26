import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';
import '../../../constants/routes.dart';

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: Device.width(64.0),
        height: Device.height(6.2),
      ),
      child: ElevatedButton(
        child: Text('SIGN IN'),
        onPressed: () => Routes.sailor('/sign_in'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => CupertinoColors.systemBlue,
          ),
        ),
      ),
    );
  }
}
