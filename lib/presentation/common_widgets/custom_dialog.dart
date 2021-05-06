import 'package:flutter/material.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../../cubit/notification/notification_cubit.dart';

/// ### Custom Dialog
/// ! Depends on sweetsheet package
class CustomDialog {
  final SweetSheet _sweetSheet;

  final String? title;
  final String description;
  final NotificationType? type;
  final IconData? descriptionIcon;
  late final CustomSheetColor _dialogType;

  final String positiveActionLabel;
  final IconData? positiveActionIcon;
  final void Function() positiveActionOnPressed;

  final String negativeActionLabel;
  final IconData? negativeActionIcon;
  final void Function() negativeActionOnPressed;

  CustomDialog(
    context, {
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
  }) : _sweetSheet = SweetSheet() {
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
    _sweetSheet.show(
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
