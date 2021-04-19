// # Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

// # Custom Elevated Button
// Made in order to maintain a consistent button style
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({@required this.child, this.onPressed});
  final Function onPressed;
  final child;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    // Defining colors of disabled button based on dark/light modes
    Color _disabledButtonColor =
        Device.brightness == Brightness.light ? Colors.black38 : Colors.white12;

    // Returning the widget
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
                    ? _disabledButtonColor
                    : Colors.blueGrey[800],
          ),
        ),
      ),
    );
  }
}
