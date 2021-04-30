import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  final NotificationBloc _notificationBloc;

  SignUpBloc(context)
      : _userRepository = UserRepository(),
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

    // * Resets the BLoC to allow for repeated events (DO NOT DELETE)
    yield SignUpInitial();
  }

  Stream<SignUpState> _mapSignUpCredentialsValidToState(
      SignUpCredentialsValid event) async* {
    _notificationBloc.add(
      AlertRequested(
        'Signing Up...',
        notificationType: NotificationType.Loading,
      ),
    );

    Map<String, dynamic> userData = _parseEventToMap(event);

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
    userData,
  }) async* {
    try {
      UserModel user = await _userRepository.createUserWithEmailAndPassword(
        email,
        password,
      );

      String displayName = "${firstName[0]}. $lastName";

      await _userRepository.updateProfile(displayName: displayName);
      await _userRepository.updateUserData(user, userData);
      _notificationBloc.add(
        AlertRequested(
          "Signed Up Successfully",
          notificationType: NotificationType.Success,
        ),
      );
      yield SignUpSuccess(user);
    } catch (e) {
      // TODO Implement Error Handling ⛔
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
      yield SignUpFailure(e.toString());
      rethrow;
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

  Map<String, dynamic> _parseEventToMap(event) {
    return {
      "names": {
        "first_name": event.firstName,
        "last_name": event.lastName,
      }
    };
  }
}
