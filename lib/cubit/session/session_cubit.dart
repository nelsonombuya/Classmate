import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_data_model.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/repositories/unit_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/authentication_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  List<Stream<QuerySnapshot>> assignmentStreamsList = [];
  List<Stream<DocumentSnapshot>> lessonStreamsList = [];
  List<SessionRepository> sessionsList = [];

  late final UserRepository _UserRepository;
  late final StreamSubscription _userDataStreamSubscription;
  final AuthenticationRepository _AuthenticationRepository =
      AuthenticationRepository();

  SessionCubit()
      : super(SessionInitial(
          [].cast<Stream<DocumentSnapshot>>(),
          [].cast<Stream<QuerySnapshot>>(),
          [].cast<SessionRepository>(),
        )) {
    if (!_AuthenticationRepository.isUserSignedIn()) {
      this.addError("There's no user signed in ❗");
      throw NullThrownError();
    }

    _UserRepository =
        UserRepository(_AuthenticationRepository.getCurrentUser()!);
    Stream _userDataStream = _UserRepository.userDataStream.asBroadcastStream();

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
    required UserModel user,
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
