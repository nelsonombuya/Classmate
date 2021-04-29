import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository = UserRepository();
  late final StreamSubscription _authStateChangesStream;

  AuthBloc() : super(AuthInitial()) {
    try {
      _authStateChangesStream = _userRepository.authStateChanges.listen(
        (user) => this.add(AuthChanged(user: user)),
      );
    } catch (e) {
      // TODO Implement proper error handling ⛔
      this.add(AuthErrorOccurred(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _authStateChangesStream.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthChanged) {
      yield (event.user == null)
          ? Unauthenticated()
          : Authenticated(event.user!);
    }

    if (event is AuthRemoved) {
      _userRepository.signOut();
      yield Unauthenticated();
    }

    if (event is AuthErrorOccurred) {
      if (_userRepository.isUserSignedIn()) _userRepository.signOut();
      yield Unauthenticated();
      yield AuthenticationError(event.errorMessage);
    }
  }
}
