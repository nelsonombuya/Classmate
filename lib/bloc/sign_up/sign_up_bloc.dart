import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/error_handler.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/firebase_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());
  UserRepository _userRepository = UserRepository();
  FirebaseRepository _databaseRepository = FirebaseRepository();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpStarted) {
      yield SignUpLoading();
      try {
        UserModel user = await _userRepository.signUpWithEmail(
          event.email,
          event.password,
        );

        Map<String, Map<String, String>> userData = {
          "names": {
            "first_name": event.firstName,
            "last_name": event.lastName,
          }
        };

        _databaseRepository.updateUserData(user, userData);

        yield SignUpSuccess(user: user);
      } catch (e) {
        yield SignUpFailure(message: ErrorHandler(e).message);
      }
    }
  }
}
