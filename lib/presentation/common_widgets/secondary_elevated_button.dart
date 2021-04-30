import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class SecondaryElevatedButton extends StatelessWidget {
  final child;
  final void Function()? onPressed;

  SecondaryElevatedButton({required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: _deviceQuery.safeWidth(64.0),
        height: _deviceQuery.safeHeight(6.2),
      ),
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.disabled)
                    ? Theme.of(context).disabledColor
                    : Colors.blueGrey[800]!,
          ),
        ),
      ),
    );
  }
}
