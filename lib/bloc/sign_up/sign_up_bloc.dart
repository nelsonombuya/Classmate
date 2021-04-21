import '../../constants/error_handler.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'dart:async';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());
  UserRepository _userRepository = UserRepository();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpStarted) {
      yield SignUpLoading();
      try {
        yield SignUpSuccess(
          user: await _userRepository.signUpWithEmail(
            event.email,
            event.password,
          ),
        );
      } catch (e) {
        yield SignUpFailure(message: ErrorHandler(e).message);
      }
    }
  }
}
