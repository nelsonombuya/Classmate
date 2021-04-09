// # Imports
import 'package:flutter/material.dart';

// # Custom Elevated Button
// Made in order to maintain a consistent button style
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({@required this.child, this.onPressed});
  final Function onPressed;
  final child;

  @override
  Widget build(BuildContext context) {
    // Defining colors of disabled button based on dark/light modes
    Color _disabledButtonColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.black38
            : Colors.white12;

    // Returning the widget
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 250, height: 50),
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return _disabledButtonColor;
              } else {
                return Colors.blueGrey[800];
              }
            },
          ),
        ),
      ),
    );
  }
}
