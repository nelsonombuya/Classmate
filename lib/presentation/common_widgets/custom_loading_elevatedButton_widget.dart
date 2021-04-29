import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants/device.dart';

/// # Custom Loading Elevated Button
/// ! Button adapted from Rounded Loading Button

class CustomLoadingElevatedButton extends StatefulWidget {
  final Color color;
  final Widget child;
  final Function onEnd;
  final Function onPressed;

  CustomLoadingElevatedButton({
    @required this.onPressed,
    this.child,
    this.onEnd,
    this.color,
  });

  @override
  _CustomLoadingElevatedButtonState createState() =>
      _CustomLoadingElevatedButtonState();
}

class _CustomLoadingElevatedButtonState
    extends State<CustomLoadingElevatedButton> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  /// * onPressed function should return bool to change between success and error states
  void onPressedExtended() async {
    try {
      bool result = await widget.onPressed();

      if (result) {
        _btnController.success();
        await Future.delayed(Duration(seconds: 1));
      } else {
        _btnController.error();
        await Future.delayed(Duration(seconds: 3));
      }

      _btnController.reset();

      if (widget.onEnd != null) widget.onEnd();
    } catch (e) {
      _btnController.error();

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
        borderRadius: 3.0,
        child: widget.child,
        controller: _btnController,
        successColor: CupertinoColors.activeGreen,
        color: widget.color ?? CupertinoColors.activeBlue,
        onPressed: widget.onPressed == null ? null : onPressedExtended,
      ),
    );
  }
}
