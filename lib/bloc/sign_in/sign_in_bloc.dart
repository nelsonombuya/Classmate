import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/notification/notification_cubit.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  final NotificationCubit _notificationCubit;

  SignInBloc(BuildContext context)
      : _userRepository = UserRepository(),
        _notificationCubit = context.read<NotificationCubit>(),
        super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInRequested) {
      yield SignInValidation();
    } else if (event is SignInCredentialsValid) {
      yield* _mapSignInCredentialsValidToState(event);
    } else if (event is SignInCredentialsInvalid) {
      yield* _mapSignInCredentialsInvalidToState(event);
    }
  }

  Stream<SignInState> _mapSignInCredentialsValidToState(
      SignInCredentialsValid event) async* {
    _notificationCubit.showAlert(
      'Signing In...',
      type: NotificationType.Loading,
    );
    yield* _signIn(event.email, event.password);
  }

  Stream<SignInState> _signIn(String email, String password) async* {
    try {
      UserModel user = await _userRepository.signInWithEmailAndPassword(
        email,
        password,
      );

      _notificationCubit.showAlert(
        "Signed In Successfully",
        type: NotificationType.Success,
      );

      yield SignInSuccess(user);
    } catch (e) {
      _notificationCubit.showAlert(
        "Error Signing In",
        type: NotificationType.Danger,
      );
      _notificationCubit.showSnackBar(
        e.toString(),
        title: "Error Signing In",
        type: NotificationType.Danger,
      );
      this.addError(e);
    }
  }

  Stream<SignInState> _mapSignInCredentialsInvalidToState(
      SignInCredentialsInvalid event) async* {
    _notificationCubit.showSnackBar(
      'Please input the required information correctly',
      title: 'Error Validating Form',
      type: NotificationType.Warning,
    );
  }
}
