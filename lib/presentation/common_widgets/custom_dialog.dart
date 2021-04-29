import 'package:flutter/material.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../../bloc/notification/notification_bloc.dart';

/// # Custom Dialog
/// Used to show custom dialog boxes throughout the app
/// ! Depends on sweetsheet package
class CustomDialog {
  final BuildContext context;
  final NotificationType? type;
  final SweetSheet sweetSheet = SweetSheet();

  late final CustomSheetColor _dialogType;
  final String? title;
  final String description;
  final IconData? descriptionIcon;

  final String positiveActionLabel;
  final IconData? positiveActionIcon;
  final void Function() positiveActionOnPressed;

  final String negativeActionLabel;
  final IconData? negativeActionIcon;
  final void Function() negativeActionOnPressed;

  CustomDialog(
    this.context, {
    this.title,
    required this.description,
    required this.positiveActionLabel,
    required this.negativeActionLabel,
    this.type,
    this.descriptionIcon,
    this.positiveActionIcon,
    required this.positiveActionOnPressed,
    this.negativeActionIcon,
    required this.negativeActionOnPressed,
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

  _showSweetSheet(BuildContext context) {
    sweetSheet.show(
      context: context,
      color: _dialogType,
      icon: descriptionIcon,
      description: Text(description),
      title: title == null ? null : Text(title!),
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
