import 'package:classmate/data/repositories/user_repository.dart';
import 'package:classmate/constants/error_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());
  UserRepository _userRepository = UserRepository();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    try {
      if (event is RegistrationStarted) {
        yield RegistrationLoading();

        var user =
            await _userRepository.createUser(event.email, event.password);

        yield RegistrationSuccess(user: user);
      }
    } catch (e) {
      yield RegistrationFailure(message: ErrorHandler(e).message);
    }
  }
}
