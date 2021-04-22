import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/error_handler.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository = UserRepository();
  StreamSubscription _authStateChangesStream;

  AuthBloc() : super(AuthInitial()) {
    try {
      // # Listening to Auth State Changes and adding events in response
      _authStateChangesStream = _userRepository.authStateChanges.listen(
        (user) => this.add(AuthChanged(user: user)),
      );
    } catch (e) {
      this.add(AuthErrorOccurred(message: ErrorHandler(e).message));
    }
  }

  // # For disposing the stream when done
  @override
  Future<void> close() async {
    await _authStateChangesStream.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // # Listening to Auth State Changes
    if (event is AuthChanged) {
      yield (event.user == null)
          ? Unauthenticated()
          : Authenticated(user: event.user);
    }

    // # Useful when Signing Out
    if (event is AuthRemoved) {
      _userRepository.signOut();
      yield Unauthenticated();
    }

    // # Useful when an authentication error occurs
    if (event is AuthErrorOccurred) {
      if (_userRepository.isUserSignedIn()) _userRepository.signOut();
      yield Unauthenticated();
      yield AuthenticationError(message: event.message);
    }
  }
}
