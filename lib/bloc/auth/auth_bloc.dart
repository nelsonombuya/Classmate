import 'package:classmate/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository _userRepository = UserRepository();
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      try {
        if (await _userRepository.isUserSignedIn()) {
          yield Authenticated(user: await _userRepository.getCurrentUser());
        } else {
          yield Unauthenticated();
        }
      } catch (e) {
        yield Unauthenticated();
        yield AuthenticationError(e.toString());
      }
    }

    if (event is AuthRemoved) {
      _userRepository.signOut();
      yield Unauthenticated();
    }
  }
}
