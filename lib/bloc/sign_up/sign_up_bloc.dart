import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/error_handler.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  UserRepository _userRepository = UserRepository();
  NotificationBloc _notificationBloc = NotificationBloc();

  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpRequested) {
      yield SignUpValidation();
    } else if (event is SignUpStarted) {
      yield SignUpLoading();
      yield* _mapSignUpStartedToEvent(event);
    }
  }

  Stream<SignUpState> _mapSignUpStartedToEvent(SignUpStarted event) async* {
    try {
      UserModel user = await _userRepository.createUserWithEmailAndPassword(
        event.email,
        event.password,
      );

      _parseEventToMap(event);

      Map<String, Map<String, String>> userData = _parseEventToMap(event);
      String displayName = "${event.firstName[0]}. ${event.lastName}";

      await _userRepository.updateProfile(displayName: displayName);
      await _userRepository.updateUserData(user, userData);

      yield SignUpSuccess(user: user);
    } catch (e) {
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Sign Up Failed",
          notificationType: NotificationType.Danger,
        ),
      );
      yield SignUpFailure(message: ErrorHandler(e).message);
    }
  }

  Map<String, dynamic> _parseEventToMap(event) {
    return {
      "names": {
        "first_name": event.firstName,
        "last_name": event.lastName,
      }
    };
  }
}
