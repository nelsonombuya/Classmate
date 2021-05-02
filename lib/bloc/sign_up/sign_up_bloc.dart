import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/auth_model.dart';
import '../../data/models/user_data_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final NotificationBloc _notificationBloc;

  SignUpBloc(BuildContext context)
      : _authRepository = AuthRepository(),
        _userRepository = UserRepository(),
        _notificationBloc = BlocProvider.of<NotificationBloc>(context),
        super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpRequested) {
      yield SignUpValidation();
    } else if (event is SignUpCredentialsValid) {
      yield* _mapSignUpCredentialsValidToState(event);
    } else if (event is SignUpCredentialsInvalid) {
      yield* _mapSignUpCredentialsInvalidToState(event);
    }
  }

  Stream<SignUpState> _mapSignUpCredentialsValidToState(
      SignUpCredentialsValid event) async* {
    _notificationBloc.add(
      AlertRequested(
        'Signing Up...',
        notificationType: NotificationType.Loading,
      ),
    );

    UserDataModel userData = UserDataModel(
      firstName: event.firstName,
      lastName: event.lastName,
    );

    yield* _signUp(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.firstName,
      userData: userData,
    );
  }

  Stream<SignUpState> _signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserDataModel userData,
  }) async* {
    try {
      AuthModel user = await _authRepository.createUserWithEmailAndPassword(
        email,
        password,
      );

      String displayName = "${firstName[0]}. $lastName";

      await _authRepository.updateProfile(displayName: displayName);
      await _userRepository.updateUserData(user, userData);

      _notificationBloc.add(
        AlertRequested(
          "Signed Up Successfully",
          notificationType: NotificationType.Success,
        ),
      );

      yield SignUpSuccess(user);
    } catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Signing Up",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Signing Up",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
    }
  }

  Stream<SignUpState> _mapSignUpCredentialsInvalidToState(
      SignUpCredentialsInvalid event) async* {
    _notificationBloc.add(
      SnackBarRequested(
        'Please input the required information correctly',
        notificationType: NotificationType.Warning,
        title: 'Error Validating Form',
      ),
    );
  }
}
