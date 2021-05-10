import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/device_query.dart';
import '../../cubit/notification/notification_cubit.dart';

/// ### Custom Snack Bar
/// ! Depends on Another FlushBar
class CustomSnackBar {
  final String? title;
  final String message;
  final BuildContext context;
  final NotificationType? type;
  late final DeviceQuery _deviceQuery;

  CustomSnackBar(this.context, {this.type, this.title, required this.message}) {
    _deviceQuery = DeviceQuery(context);
    _showSnackBar();
  }

  Flushbar _template({
    IconData? icon,
    Color? iconColor,
    Color? titleColor,
    Color? messageColor,
    Color? backgroundColor,
    bool shouldIconPulse = false,
  }) {
    return Flushbar(
      title: title,
      message: message,
      titleColor: titleColor,
      messageColor: messageColor,
      duration: Duration(seconds: 5),
      shouldIconPulse: shouldIconPulse,
      messageSize: _deviceQuery.safeHeight(1.86),
      positionOffset: _deviceQuery.safeHeight(5.0),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: backgroundColor ?? CupertinoColors.darkBackgroundGray,
      margin: EdgeInsets.symmetric(
        horizontal: _deviceQuery.safeWidth(3.0),
        vertical: _deviceQuery.safeHeight(10.0),
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: _deviceQuery.safeWidth(2.0)),
        child: Icon(
          icon,
          size: _deviceQuery.safeHeight(3.0),
          color: iconColor ?? CupertinoColors.white,
        ),
      ),
    )..show(context); // TODO Stacking Notifications
  }

  void _showSnackBar() {
    switch (type) {
      case NotificationType.Info:
        _template(icon: Icons.info_outline_rounded);
        break;

      case NotificationType.Warning:
        _template(
          iconColor: CupertinoColors.white,
          icon: Icons.warning_amber_rounded,
          messageColor: CupertinoColors.white,
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
