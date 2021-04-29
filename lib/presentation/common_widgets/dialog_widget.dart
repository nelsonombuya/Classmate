import 'package:classmate/bloc/notification/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sweetsheet/sweetsheet.dart';

/// # Custom Dialog
/// Used to show custom dialog boxes throughout the app
/// ! Depends on sweetsheet package
class CustomDialog {
  CustomDialog(
    this.context, {
    @required this.title,
    @required this.description,
    @required this.positiveActionLabel,
    @required this.negativeActionLabel,
    this.type,
    this.descriptionIcon,
    this.positiveActionIcon,
    this.positiveActionOnPressed,
    this.negativeActionIcon,
    this.negativeActionOnPressed,
  }) {
    switch (type) {
      case NotificationType.Info:
        _dialogType = SweetSheetColor.NICE;
        break;
      case NotificationType.Warning:
        _dialogType = SweetSheetColor.WARNING;
        break;
      case NotificationType.Danger:
        _dialogType = SweetSheetColor.DANGER;
        break;
      case NotificationType.Success:
        _dialogType = SweetSheetColor.SUCCESS;
        break;
      default:
        _dialogType = SweetSheetColor.NICE;
        break;
    }

    _showSweetSheet(context);
  }

  final BuildContext context;
  final NotificationType type;
  final SweetSheet sweetSheet = SweetSheet();

  CustomSheetColor _dialogType;
  final String title, description;
  final IconData descriptionIcon;

  final String positiveActionLabel;
  final IconData positiveActionIcon;
  final Function positiveActionOnPressed;

  final String negativeActionLabel;
  final IconData negativeActionIcon;
  final Function negativeActionOnPressed;

  _showSweetSheet(BuildContext context) {
    sweetSheet.show(
      context: context,
      title: Text(title),
      color: _dialogType,
      icon: descriptionIcon,
      description: Text(description),
      positive: SweetSheetAction(
        icon: positiveActionIcon,
        title: positiveActionLabel,
        onPressed: positiveActionOnPressed,
      ),
      negative: SweetSheetAction(
        icon: negativeActionIcon,
        title: negativeActionLabel,
        onPressed: negativeActionOnPressed,
      ),
    );
  }
}
