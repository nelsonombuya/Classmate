import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

part 'notification_state.dart';

enum NotificationType { Loading, Info, Warning, Danger, Success }
enum DialogType { DeleteEvent, DeleteTask }

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void showSnackBar(String message, {String? title, NotificationType? type}) {
    emit(ShowSnackBar(
      message,
      title: title,
      notificationType: type,
    ));
  }

  void showDialogBox(
    String message, {
    String? title,
    NotificationType? type,
    IconData? descriptionIcon,
    IconData? positiveActionIcon,
    required String positiveActionLabel,
    required String negativeActionLabel,
    required void Function() positiveActionOnPressed,
    required void Function() negativeActionOnPressed,
  }) {
    emit(ShowDialogBox(
      message,
      title: title,
      notificationType: type,
      descriptionIcon: descriptionIcon,
      positiveActionIcon: positiveActionIcon,
      positiveActionLabel: positiveActionLabel,
      negativeActionLabel: negativeActionLabel,
      negativeActionOnPressed: negativeActionOnPressed,
      positiveActionOnPressed: positiveActionOnPressed,
    ));
  }

  void showAlert(String message, {NotificationType? type}) {
    emit(ShowAlert(
      message,
      notificationType: type,
    ));
  }

  void showSignOutDialog(BuildContext context) {
    return showDialogBox(
      "Are you sure you want to sign out?",
      title: "Sign Out",
      type: NotificationType.Danger,
      negativeActionLabel: "CANCEL",
      positiveActionLabel: "SIGN OUT",
      positiveActionIcon: Icons.logout,
      descriptionIcon: Icons.warning_amber_rounded,
      positiveActionOnPressed: () {
        Navigator.of(context).pop();
        context.read<AuthBloc>().add(AuthRemoved());
      },
      negativeActionOnPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void showDeleteDialog(
      BuildContext context, DialogType type, Function deleteFunction) {
    String objectToBeDeleted;

    switch (type) {
      case DialogType.DeleteEvent:
        objectToBeDeleted = "Event";
        break;
      case DialogType.DeleteTask:
        objectToBeDeleted = "Task";
        break;
      default:
        objectToBeDeleted = "";
        break;
    }

    return showDialogBox(
      "Are you sure you want to delete this $objectToBeDeleted?",
      title: "Delete",
      positiveActionLabel: "DELETE ${objectToBeDeleted.toUpperCase()}",
      negativeActionLabel: "CANCEL",
      descriptionIcon: Icons.delete_rounded,
      positiveActionIcon: Icons.delete_rounded,
      type: NotificationType.Danger,
      positiveActionOnPressed: () {
        Navigator.of(context).pop();
        deleteFunction();
      },
      negativeActionOnPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
