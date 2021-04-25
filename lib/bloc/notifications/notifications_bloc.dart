import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/enums.dart';
import '../auth/auth_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial());
  AuthBloc _authBloc = AuthBloc();

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    if (event is SnackBarRequested) {
      yield ShowSnackBar(
        event.message,
        title: event.title,
        notificationType: event.notificationType,
      );

      // HACK To allow the Snack Bar to show Multiple Times
      // Despite having the same message
      // ! Might be unnecessary, but was helpful with testing
      yield Reset();
    }

    // * Mostly used for testing and quick hacks
    // ! Prefer standardized Dialog Boxes with simpler events
    if (event is DialogBoxRequested) {
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

    if (event is SignOutDialogBoxRequested) {
      yield ShowDialogBox(
        "Are you sure you want to sign out?",
        positiveActionOnPressed: () {
          Navigator.of(event.context).pop();
          _authBloc.add(AuthRemoved());
        },
        title: "Sign Out",
        negativeActionLabel: "CANCEL",
        positiveActionLabel: "SIGN OUT",
        positiveActionIcon: Icons.logout,
        notificationType: NotificationType.Danger,
        descriptionIcon: Icons.warning_amber_rounded,
        negativeActionOnPressed: () => Navigator.of(event.context).pop(),
      );
    }
  }
}
