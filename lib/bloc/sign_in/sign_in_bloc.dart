import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  final UserRepository _userRepository = UserRepository();
  final NotificationBloc _notificationBloc = NotificationBloc();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInRequested) {
      yield SignInValidation();
    } else if (event is SignInStarted) {
      yield* _mapSignInStartedToState(event);
    }
  }

  Stream<SignInState> _mapSignInStartedToState(SignInStarted event) async* {
    try {
      yield SignInLoading();
      _notificationBloc.add(SnackBarRequested('Signing In... Please Wait.'));

      UserModel user = await _userRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );

      yield SignInSuccess(user: user);
    } catch (e) {
      yield SignInFailure(message: e.toString());
    }
  }
}
