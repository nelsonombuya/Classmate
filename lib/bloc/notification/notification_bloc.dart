import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/auth_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

enum NotificationType { Danger, Info, Warning, Success }

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationsInitial());
  AuthBloc _authBloc = AuthBloc();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is SnackBarRequested) {
      yield* _mapSnackBarRequestedToState(event);
    } else if (event is DialogBoxRequested) {
      yield* _mapDialogBoxRequestedToState(event);
    } else if (event is SignOutDialogBoxRequested) {
      yield* _mapSignOutDialogBoxRequestedToState(event);
    }
  }

  Stream<NotificationState> _mapSnackBarRequestedToState(
      SnackBarRequested event) async* {
    yield ShowSnackBar(
      title: event.title,
      message: event.message,
      notificationType: event.notificationType,
    );
  }

  Stream<NotificationState> _mapDialogBoxRequestedToState(
      DialogBoxRequested event) async* {
    yield ShowDialogBox(
      title: event.title,
      message: event.message,
      descriptionIcon: event.descriptionIcon,
      notificationType: event.notificationType,
      positiveActionIcon: event.positiveActionIcon,
      positiveActionLabel: event.positiveActionLabel,
      negativeActionLabel: event.negativeActionLabel,
      negativeActionOnPressed: event.negativeActionOnPressed,
      positiveActionOnPressed: event.positiveActionOnPressed,
    );
  }

  Stream<NotificationState> _mapSignOutDialogBoxRequestedToState(
      SignOutDialogBoxRequested event) async* {
    yield ShowDialogBox(
      title: "Sign Out",
      message: "Are you sure you want to sign out?",
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
}
