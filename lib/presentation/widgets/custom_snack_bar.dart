// # Imports
import 'package:another_flushbar/flushbar.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// # Custom Snack Bar
/// Used to give snack bar notifications to the user
/// Works throughout the app
class CustomSnackBar {
  final NotificationType type;
  final BuildContext context;
  final String message;
  final String title;

  CustomSnackBar(
    this.context, {
    @required this.message,
    this.title,
    this.type,
  }) {
    Device().init(context);
    _showSnackBar();
  }

  /// ## Template to be used by all Snack Bars
  /// Minimizes redundancy
  Flushbar _template({
    IconData icon,
    Color iconColor,
    Color titleColor,
    Color messageColor,
    Color backgroundColor,
    bool shouldIconPulse = false,
  }) {
    return Flushbar(
      title: title,
      message: message,
      titleColor: titleColor,
      messageColor: messageColor,
      duration: Duration(seconds: 5),
      shouldIconPulse: shouldIconPulse,
      messageSize: Device.height(1.86),
      positionOffset: Device.height(10.0),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: backgroundColor ?? CupertinoColors.darkBackgroundGray,
      margin: EdgeInsets.symmetric(
        horizontal: Device.width(3.0),
        vertical: Device.height(1.0),
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: Device.width(2.0)),
        child: Icon(
          icon,
          size: Device.height(3.0),
          color: iconColor ?? CupertinoColors.white,
        ),
      ),
    )..show(context);
  }

  /// ## Show Snack Bar
  /// Shows the snackbar according to the predefined template
  void _showSnackBar() {
    switch (type) {
      case NotificationType.Info:
        _template(icon: Icons.info_outline_rounded);
        break;

      case NotificationType.Warning:
        _template(
          iconColor: CupertinoColors.white,
          messageColor: CupertinoColors.white,
          icon: Icons.warning_amber_rounded,
          backgroundColor: CupertinoColors.activeOrange,
        );
        break;

      case NotificationType.Danger:
        _template(
          icon: Icons.error_outline_rounded,
          backgroundColor: CupertinoColors.destructiveRed,
        );
        break;

      case NotificationType.Success:
        _template(
          icon: Icons.error_outline_rounded,
          backgroundColor: CupertinoColors.activeGreen,
        );
        break;

      default:
        _template(icon: Icons.assistant_photo_rounded);
        break;
    }
  }
}
