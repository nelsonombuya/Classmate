import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/auth_model.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository _authRepository;
  late final StreamSubscription _authStateChangesStream;

  AuthBloc() : super(AuthInitial()) {
    try {
      _authRepository = AuthRepository();
      _authStateChangesStream = _authRepository.authStateChanges.listen(
        (user) => this.add(AuthChanged(user: user)),
      );
    } catch (e) {
      this.addError(AuthErrorOccurred(e.toString()));
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _authStateChangesStream.cancel();
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
      _authRepository.signOut();
      yield Unauthenticated();
    }

    if (event is AuthErrorOccurred) {
      if (_authRepository.isUserSignedIn()) _authRepository.signOut();
      yield Unauthenticated();
      yield AuthenticationError(event.errorMessage);
    }
  }
}
