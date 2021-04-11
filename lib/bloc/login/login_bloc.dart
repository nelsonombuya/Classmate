import 'dart:async';

import 'package:classmate/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({this.userRepository}) : super(LoginInitial());
  final UserRepository userRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is SignInButtonPressed) {
        yield LoginLoading();
        var user = await userRepository.signIn(event.email, event.password);
        yield LoginSuccess(user: user);
      }
    } on Exception catch (e) {
      yield LoginFailure(message: e.toString());
    }
  }
}
