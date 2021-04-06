import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({@required this.child, this.onPressed});
  final Function onPressed;
  final child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 250, height: 50),
      child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.white12;
              } else {
                return Colors.blueGrey[800];
              }
            },
          ))),
    );
  }
}
