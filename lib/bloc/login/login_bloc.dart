import 'dart:async';

import 'package:classmate/constants/error_handler.dart';
import 'package:classmate/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = UserRepository();
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStarted) {
      yield LoginLoading();
      try {
        var user = await userRepository.signIn(event.email, event.password);
        yield LoginSuccess(user: user);
      } catch (e) {
        yield LoginFailure(message: ErrorHandler(e).message);
      }
    }
  }
}
