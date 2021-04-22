import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/error_handler.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  final UserRepository _userRepository = UserRepository();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInStarted) {
      yield SignInLoading();
      try {
        yield SignInSuccess(
          user: await _userRepository.signInWithEmail(
            event.email,
            event.password,
          ),
        );
      } catch (e) {
        yield SignInFailure(message: ErrorHandler(e).message);
      }
    }
  }
}
