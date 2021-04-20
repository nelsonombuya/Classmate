import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'dart:async';

import '../../data/repositories/user_repository.dart';
import '../../constants/error_handler.dart';
import '../../data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository _userRepository = UserRepository();
  StreamSubscription _authStateChangesStream;

  AuthBloc() : super(AuthInitial()) {
    // # Listening to Auth State Changes
    _authStateChangesStream = _userRepository.authStateChanges.listen(
      (user) => this.add(AuthChanged(user: user)),
    );
  }

  // # For Disposing the Stream
  @override
  Future<void> close() {
    _authStateChangesStream.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // # Listening to Auth State Changes
    if (event is AuthChanged) {
      try {
        yield (event.user == null)
            ? Unauthenticated()
            : Authenticated(user: event.user);
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
