import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../navigation/navigation_cubit.dart';

part 'notification_state.dart';

enum NotificationType { Loading, Info, Warning, Danger, Success }
enum DialogType { DeleteEvent, DeleteTask }

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required NavigationCubit navigationCubit,
    required AuthenticationBloc authenticationBloc,
  })   : _navigationCubit = navigationCubit,
        _authenticationBloc = authenticationBloc,
        super(NotificationInitial());

  final NavigationCubit _navigationCubit;
  final AuthenticationBloc _authenticationBloc;

  void showSnackBar(String message, {String? title, NotificationType? type}) {
    emit(ShowSnackBar(
      message,
      title: title,
      notificationType: type,
    ));
    // ! Resets state to allow stacking of snack bars. DO NOT DELETE!
    return emit(NotificationInitial());
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
    return emit(ShowDialogBox(
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
    return emit(ShowAlert(
      message,
      notificationType: type,
    ));
  }

  void showSignOutDialog() {
    return showDialogBox(
      "Are you sure you want to sign out?",
      title: "Sign Out",
      type: NotificationType.Danger,
      negativeActionLabel: "CANCEL",
      positiveActionLabel: "SIGN OUT",
      positiveActionIcon: Icons.logout,
      descriptionIcon: Icons.warning_amber_rounded,
      positiveActionOnPressed: () {
        _navigationCubit.popCurrentPage();
        return _authenticationBloc.add(AuthenticationLogoutRequested());
      },
      negativeActionOnPressed: () {
        return _navigationCubit.popCurrentPage();
      },
    );
  }

  void showDeleteDialog(DialogType type, Function deleteFunction) {
    String objectToBeDeleted;
    switch (type) {
      case DialogType.DeleteEvent:
        objectToBeDeleted = "event";
        break;
      case DialogType.DeleteTask:
        objectToBeDeleted = "task";
        break;
      default:
        objectToBeDeleted = "";
        break;
    }

    return showDialogBox(
      "Are you sure you want to delete this $objectToBeDeleted?",
      title: "Delete $objectToBeDeleted",
      positiveActionLabel: "DELETE ${objectToBeDeleted.toUpperCase()}",
      negativeActionLabel: "CANCEL",
      descriptionIcon: Icons.delete_rounded,
      positiveActionIcon: Icons.delete_rounded,
      type: NotificationType.Danger,
      positiveActionOnPressed: () {
        _navigationCubit.popCurrentPage();
        return deleteFunction();
      },
      negativeActionOnPressed: () {
        return _navigationCubit.popCurrentPage();
      },
    );
  }
}
