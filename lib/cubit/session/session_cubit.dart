import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:classmate/data/repositories/unit_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/course_repository.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  List<Stream<DocumentSnapshot>> sessionStreamsList = [];

  late final StreamSubscription _userDataStreamSubscription;
  late final UserRepository _userRepository;
  final AuthRepository _authRepository = AuthRepository();

  SessionCubit() : super(SessionInitial([].cast<Stream<DocumentSnapshot>>())) {
    if (!_authRepository.isUserSignedIn()) {
      this.addError("There's no user signed in ❗");
      throw NullThrownError();
    }

    _userRepository = UserRepository(_authRepository.getCurrentUser()!);
    Stream _userDataStream = _userRepository.userDataStream.asBroadcastStream();

    // * Gets a list of units that the user has registered for
    _userDataStreamSubscription = _userDataStream.listen((snapshot) {
      if (snapshot != null && snapshot.registeredUnits != null) {
        snapshot.registeredUnits!.forEach((unit) {
          // * Gets the current session for the registered unit
          UnitRepository().getUnitDetails(unit).then((value) {
            var currentSession = (value.data() != null &&
                    value.data()!['currentSession'] != null)
                ? value.data()!['currentSession']
                : 'FEB_MAY_2021';

            // * Gets the stream for the current session in the registered unit
            var stream = SessionRepository(unit, currentSession)
                .sessionDataStream
                .asBroadcastStream();

            // * Adds the session's stream to the list of streams to be listened to
            if (!sessionStreamsList.contains(stream)) {
              sessionStreamsList.add(stream);
            }

            // * Emits the new list of streams
            emit(SessionStreamListChanged(sessionStreamsList));
          });
        });
      }
    });
  }

  @override
  Future<void> close() {
    _userDataStreamSubscription.cancel();
    return super.close();
  }
}
