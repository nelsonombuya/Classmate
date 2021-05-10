import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    required String label,
    void Function()? onPressed,
    bool secondary = false,
  })  : _label = label,
        _secondary = secondary,
        _onPressed = onPressed;

  final String _label;
  final bool _secondary;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: _deviceQuery.safeWidth(64.0),
        height: _deviceQuery.safeHeight(6.2),
      ),
      child: ElevatedButton(
        child: Text(
          _label,
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: _onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.disabled)
                    ? Theme.of(context).disabledColor
                    : _secondary
                        ? Colors.blueGrey[800]!
                        : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
