import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final child;

  const CustomElevatedButton({@required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: Device.width(64.0),
        height: Device.height(6.2),
      ),
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.disabled)
                    ? CupertinoColors.inactiveGray
                    : Colors.blueGrey[800],
          ),
        ),
      ),
    );
  }
}
