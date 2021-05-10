import 'package:flutter/material.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../../cubit/notification/notification_cubit.dart';

/// ### Custom Dialog
/// ! Depends on sweetsheet package
class CustomDialog {
  CustomDialog(
    BuildContext context, {
    String? title,
    NotificationType? type,
    IconData? descriptionIcon,
    IconData? positiveActionIcon,
    IconData? negativeActionIcon,
    required String description,
    required String positiveActionLabel,
    required void Function() positiveActionOnPressed,
    required String negativeActionLabel,
    required void Function() negativeActionOnPressed,
  })   : _sweetSheet = SweetSheet(),
        _title = title,
        _description = description,
        _descriptionIcon = descriptionIcon,
        _positiveActionLabel = positiveActionLabel,
        _positiveActionIcon = positiveActionIcon,
        _positiveActionOnPressed = positiveActionOnPressed,
        _negativeActionLabel = negativeActionLabel,
        _negativeActionIcon = negativeActionIcon,
        _negativeActionOnPressed = negativeActionOnPressed {
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

  final SweetSheet _sweetSheet;

  final String? _title;
  final String _description;
  final IconData? _descriptionIcon;
  late final CustomSheetColor _dialogType;

  final String _positiveActionLabel;
  final IconData? _positiveActionIcon;
  final void Function() _positiveActionOnPressed;

  final String _negativeActionLabel;
  final IconData? _negativeActionIcon;
  final void Function() _negativeActionOnPressed;

  _showSweetSheet(BuildContext context) {
    _sweetSheet.show(
      context: context,
      color: _dialogType,
      icon: _descriptionIcon,
      description: Text(_description),
      title: _title == null ? null : Text(_title!),
      positive: SweetSheetAction(
        icon: _positiveActionIcon,
        title: _positiveActionLabel,
        onPressed: _positiveActionOnPressed,
      ),
      negative: SweetSheetAction(
        icon: _negativeActionIcon,
        title: _negativeActionLabel,
        onPressed: _negativeActionOnPressed,
      ),
    );
  }
}
