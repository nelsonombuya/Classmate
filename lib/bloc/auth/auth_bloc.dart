import 'package:classmate/data/repositories/user_repository.dart';
import 'package:classmate/constants/error_handler.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  UserRepository _userRepository = UserRepository();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // # Listening to Auth State Changes
    await for (var user in _userRepository.authStateChanges) {
      try {
        yield (user == null) ? Unauthenticated() : Authenticated(user: user);
      } catch (e) {
        yield Unauthenticated();
        yield AuthenticationError(message: ErrorHandler(e).message);
      }
    }

    // # Useful when Signing Out
    if (event is AuthRemoved) {
      _userRepository.signOut();
      yield Unauthenticated();
    }
  }
}
