import 'package:classmate/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository _userRepository;

  AuthBloc(this._userRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      try {
        bool isUserSignedIn = await _userRepository.isUserSignedIn();
        if (isUserSignedIn) {
          var user = await _userRepository.getCurrentUser();
          yield Authenticated(user: user);
        } else {
          yield Unauthenticated();
        }
      } catch (e) {
        print(e.toString()); // TODO Add Logging
        yield Unauthenticated();
      }
    }
  }
}
