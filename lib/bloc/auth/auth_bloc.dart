import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final UserRepository _UserRepository;
  late final StreamSubscription _authStateChangesStream;

  AuthBloc() : super(AuthInitial()) {
    try {
      _UserRepository = UserRepository();
      _authStateChangesStream = _UserRepository.authStateChanges.listen(
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
      _UserRepository.signOut();
      yield Unauthenticated();
    }

    if (event is AuthErrorOccurred) {
      if (_UserRepository.isUserSignedIn()) _UserRepository.signOut();
      yield Unauthenticated();
      yield AuthenticationError(event.errorMessage);
    }
  }
}
