import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/error_handler.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

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
        // Signing up the new user
        UserModel user = await _userRepository.signUpWithEmail(
          event.email,
          event.password,
        );

        // Setting their other sign in data
        Map<String, Map<String, String>> userData = {
          "names": {
            "first_name": event.firstName,
            "last_name": event.lastName,
          }
        };

        String displayName = "${event.firstName[0]}. ${event.lastName}";

        // Saving their data to the database
        await _userRepository.updateProfile(displayName: displayName);
        await _userRepository.updateUserData(user, userData);

        // Yielding a final success
        yield SignUpSuccess(user: user);
      } catch (e) {
        yield SignUpFailure(message: ErrorHandler(e).message);
      }
    }
  }
}
