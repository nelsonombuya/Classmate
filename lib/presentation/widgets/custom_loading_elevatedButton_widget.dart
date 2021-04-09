// # Imports
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// # Custom Loading Elevated Button
/// Button adapted from Rounded Loading Button
/// Customised to look like a regular elevated button
/// But still shows animations for each state it's in
class CustomLoadingElevatedButton extends StatefulWidget {
  CustomLoadingElevatedButton({
    @required this.onPressed,
    @required this.onSuccess,
    @required this.onFailure,
    this.child,
    this.successWaitingTime = const Duration(seconds: 3),
    this.failureWaitingTime = const Duration(seconds: 3),
  });
  final dynamic child;
  final Function onPressed;
  final Function onSuccess;
  final Function onFailure;
  final Duration successWaitingTime;
  final Duration failureWaitingTime;

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
      if (await widget.onPressed()) {
        // If the function returns true
        _btnController.success();

        // Wait a little before resetting
        Timer(widget.successWaitingTime, () {
          _btnController.reset();

          // Do what should be done after success
          widget.onSuccess();
        });
      } else {
        // If the function returns an false
        _btnController.error();

        // Wait a little before resetting
        Timer(widget.failureWaitingTime, () {
          _btnController.reset();

          // Do what should be done after failure
          widget.onFailure();
        });
      }
    } catch (e) {
      // If there was an error in function return type
      _btnController.error();
      print('Error: onPressed function should only return bool!');
      print('Error Message: $e');

      // Wait a little before resetting
      Timer(Duration(seconds: 5), () {
        _btnController.reset();

        // Do what should be done after failure
        widget.onFailure();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 250, height: 50),
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
