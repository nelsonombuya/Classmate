import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/auth_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

enum NotificationType { Danger, Info, Warning, Success, Loading }

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  AuthBloc _authBloc = AuthBloc();

  NotificationBloc() : super(NotificationsInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is SnackBarRequested) {
      yield* _mapSnackBarRequestedToState(event);
    } else if (event is DialogBoxRequested) {
      yield* _mapDialogBoxRequestedToState(event);
    } else if (event is AlertRequested) {
      yield* _mapAlertRequestedToState(event);
    } else if (event is SignOutDialogBoxRequested) {
      yield* _mapSignOutDialogBoxRequestedToState(event);
    } else if (event is DeleteDialogBoxRequested) {
      yield* _mapDeleteDialogBoxRequestedToState(event);
    }

    // * Resets the BLoC to allow for repeated events (DO NOT DELETE)
    yield NotificationsInitial();
  }

  Stream<NotificationState> _mapSnackBarRequestedToState(
      SnackBarRequested event) async* {
    yield ShowSnackBar(
      event.message,
      title: event.title,
      notificationType: event.notificationType,
    );
  }

  Stream<NotificationState> _mapDialogBoxRequestedToState(
      DialogBoxRequested event) async* {
    yield ShowDialogBox(
      event.message,
      title: event.title,
      descriptionIcon: event.descriptionIcon,
      notificationType: event.notificationType,
      positiveActionIcon: event.positiveActionIcon,
      positiveActionLabel: event.positiveActionLabel,
      negativeActionLabel: event.negativeActionLabel,
      negativeActionOnPressed: event.negativeActionOnPressed,
      positiveActionOnPressed: event.positiveActionOnPressed,
    );
  }

  Stream<NotificationState> _mapAlertRequestedToState(
      AlertRequested event) async* {
    yield ShowAlert(
      event.message,
      notificationType: event.notificationType,
    );
  }

  Stream<NotificationState> _mapSignOutDialogBoxRequestedToState(
      SignOutDialogBoxRequested event) async* {
    yield ShowDialogBox(
      "Are you sure you want to sign out?",
      title: "Sign Out",
      positiveActionLabel: "SIGN OUT",
      negativeActionLabel: "CANCEL",
      positiveActionIcon: Icons.logout,
      notificationType: NotificationType.Danger,
      descriptionIcon: Icons.warning_amber_rounded,
      positiveActionOnPressed: () {
        Navigator.of(event.context).pop();
        _authBloc.add(AuthRemoved());
      },
      negativeActionOnPressed: () {
        Navigator.of(event.context).pop();
      },
    );
  }

  Stream<NotificationState> _mapDeleteDialogBoxRequestedToState(
      DeleteDialogBoxRequested event) async* {
    yield ShowDialogBox(
      "Are you sure you want to delete this?",
      title: "Delete",
      positiveActionLabel: "DELETE",
      negativeActionLabel: "CANCEL",
      descriptionIcon: Icons.delete_rounded,
      positiveActionIcon: Icons.delete_rounded,
      notificationType: NotificationType.Danger,
      positiveActionOnPressed: () {
        Navigator.of(event.context).pop();
        event.deleteFunction();
      },
      negativeActionOnPressed: () {
        Navigator.of(event.context).pop();
      },
    );
  }
}
