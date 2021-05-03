import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/course_repository.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  late final _userDataStream;
  late final UserRepository _userRepository;
  List<Stream<DocumentSnapshot>> sessionStreamsList = [];
  final AuthRepository _authRepository = AuthRepository();
  final CourseRepository _courseRepository = CourseRepository();

  SessionCubit() : super(SessionInitial([].cast<Stream<DocumentSnapshot>>())) {
    if (!_authRepository.isUserSignedIn()) {
      this.addError("There's no user signed in ❗");
      throw NullThrownError();
    }

    _userRepository = UserRepository(_authRepository.getCurrentUser()!);
    _userDataStream = _userRepository.userDataStream;
    _userDataStream.listen((snapshot) {
      if (snapshot != null &&
          snapshot.registeredUnits != null &&
          snapshot.currentSession) {
        snapshot.registeredUnits!.forEach((unitReference) {
          var currentSession;
          CourseRepository.course(unitReference)
              .getCourseDetails()
              .then((value) {
            currentSession = value.data() != null
                ? value.data()!['currentSession']
                : 'FEB_MAY_2021';
          });

          var stream = SessionRepository(unitReference, currentSession)
              .sessionDataStream;

          if (!sessionStreamsList.contains(stream)) {
            sessionStreamsList.add(stream);
          }
        });

        emit(SessionStreamListChanged(sessionStreamsList));
      }
    });
  }

  @override
  Future<void> close() {
    _userDataStream.cancel();
    return super.close();
  }
}
