import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  final NotificationBloc _notificationBloc;

  SignInBloc(context)
      : _userRepository = UserRepository(),
        _notificationBloc = BlocProvider.of<NotificationBloc>(context),
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

    // * Resets the BLoC to allow for repeated events (DO NOT DELETE)
    yield SignInInitial();
  }

  Stream<SignInState> _mapSignInCredentialsValidToState(
      SignInCredentialsValid event) async* {
    _notificationBloc.add(
      AlertRequested(
        'Signing In...',
        notificationType: NotificationType.Loading,
      ),
    );
    yield* _signIn(event.email, event.password);
  }

  Stream<SignInState> _signIn(String email, String password) async* {
    try {
      UserModel user = await _userRepository.signInWithEmailAndPassword(
        email,
        password,
      );
      _notificationBloc.add(
        AlertRequested(
          "Signed In Successfully",
          notificationType: NotificationType.Success,
        ),
      );
      yield SignInSuccess(user);
    } catch (e) {
      // TODO Implement Error Handling ⛔
      _notificationBloc.add(
        AlertRequested(
          "Error Signing In",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Signing In",
          notificationType: NotificationType.Danger,
        ),
      );
      yield SignInFailure(e.toString());
      rethrow;
    }
  }

  Stream<SignInState> _mapSignInCredentialsInvalidToState(
      SignInCredentialsInvalid event) async* {
    _notificationBloc.add(
      SnackBarRequested(
        'Please input the required information correctly',
        notificationType: NotificationType.Warning,
        title: 'Error Validating Form',
      ),
    );
  }
}
