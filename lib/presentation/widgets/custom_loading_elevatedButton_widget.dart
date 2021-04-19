// # Imports
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// # Custom Loading Elevated Button
/// Button adapted from Rounded Loading Button
/// Customised to look like a regular elevated button
/// But still shows animations for each state it's in
class CustomLoadingElevatedButton extends StatefulWidget {
  CustomLoadingElevatedButton({
    @required this.onPressed,
    this.child,
    this.onEnd,
  });

  final Function onPressed;
  final Function onEnd;
  final Widget child;

  @override
  _CustomLoadingElevatedButtonState createState() =>
      _CustomLoadingElevatedButtonState();
}

class _CustomLoadingElevatedButtonState
    extends State<CustomLoadingElevatedButton> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  // * Extending the onPressed Functionality
  void onPressedExtended() async {
    try {
      await widget.onPressed()
          ? _btnController.success()
          : _btnController.error();

      // Wait a little before resetting
      await Future.delayed(Duration(seconds: 3));
      _btnController.reset();
      if (widget.onEnd != null) widget.onEnd();
    } catch (e) {
      // If there was an error in function return type
      _btnController.error();
      print('Error: onPressed function should only return bool!');
      print('Error Message: $e');

      // Wait a little before resetting
      await Future.delayed(Duration(seconds: 5));
      _btnController.reset();
      if (widget.onEnd != null) widget.onEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: Device.width(64.0),
        height: Device.height(6.2),
      ),
      child: RoundedLoadingButton(
        onPressed: widget.onPressed == null ? null : onPressedExtended,
        controller: _btnController,
        successColor: Colors.green,
        borderRadius: 3.0,
        child: widget.child,
      ),
    );
  }
}
