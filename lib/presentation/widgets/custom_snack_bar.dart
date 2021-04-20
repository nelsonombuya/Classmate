// # Imports
import 'package:classmate/constants/device.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:classmate/constants/enums.dart';
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
    // Setting the Dimensions
    Device().init(context);
    _showSnackBar();
  }

  /// # Template to be used by all Snack Bars
  /// Minimizes redundancy
  Flushbar _template({IconData icon, Color iconColor, Color backgroundColor}) {
    return Flushbar(
      title: title,
      message: message,
      messageSize: Device.height(1.86),
      margin: EdgeInsets.symmetric(
        horizontal: Device.width(3.0),
        vertical: Device.height(1.0),
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: backgroundColor ?? Color(0xFF303030),
      icon: Padding(
        padding: EdgeInsets.only(left: Device.width(2.0)),
        child: Icon(
          icon,
          size: Device.height(3.0),
          color: iconColor ?? Colors.white,
        ),
      ),
      shouldIconPulse: false,
      duration: Duration(seconds: 5),
    )..show(context);
  }

  /// # Show Snack Bar
  /// Shows the snackbar according to the predefined template
  void _showSnackBar() {
    switch (type) {
      case (NotificationType.Error):
        _template(
          icon: Icons.error_outline_rounded,
          backgroundColor: Device.brightness == Brightness.light
              ? Colors.red[400]
              : Colors.red[600],
        );
        break;

      case (NotificationType.Info):
        _template(icon: Icons.error_outline_rounded, iconColor: Colors.blue);
        break;

      default:
        _template(icon: Icons.assistant_photo_rounded);
        break;
    }
  }
}
