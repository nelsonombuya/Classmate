import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/auth_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/repositories/unit_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  List<Stream<QuerySnapshot>> assignmentStreamsList = [];
  List<Stream<DocumentSnapshot>> lessonStreamsList = [];
  List<SessionRepository> sessionsList = [];

  late final UserRepository _userRepository;
  late final StreamSubscription _userDataStreamSubscription;
  final AuthRepository _authRepository = AuthRepository();

  SessionCubit()
      : super(SessionInitial(
          [].cast<Stream<DocumentSnapshot>>(),
          [].cast<Stream<QuerySnapshot>>(),
          [].cast<SessionRepository>(),
        )) {
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

            // * Getting the current session details
            var session = SessionRepository(unit, currentSession);

            // * Gets the stream for the current session in the registered unit
            var stream = session.sessionDataStream.asBroadcastStream();

            // * Adds the session's stream to the list of streams to be listened to
            if (!lessonStreamsList.contains(stream)) {
              lessonStreamsList.add(stream);
            }

            // * Get the assignments for that session
            var assignmentsStream =
                session.assignmentsDataStream.asBroadcastStream();

            // * Adds the session's assignment stream to the list of streams to be listened to
            if (!assignmentStreamsList.contains(assignmentsStream)) {
              sessionsList.add(session);
              assignmentStreamsList.add(assignmentsStream);
            }

            // * Emits the new list of streams
            emit(SessionStreamListChanged(
              lessonStreamsList,
              assignmentStreamsList,
              sessionsList,
            ));
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

  void updateAssignmentDetails({
    required SessionRepository session,
    required String assignmentId,
    required AuthModel user,
    required bool value,
  }) {
    session.updateAssignmentForUser(
      assignmentID: assignmentId,
      user: user,
      userData: {
        "users": {"${user.uid}": value}
      },
    );
  }
}
