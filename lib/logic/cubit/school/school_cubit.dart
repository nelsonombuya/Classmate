import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/assignment_model.dart';
import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/unit_model.dart';
import 'package:classmate/data/models/user_data_model.dart';
import 'package:classmate/data/repositories/assignment_repository.dart';

import 'package:classmate/data/repositories/lesson_repository.dart';
import 'package:classmate/data/repositories/unit_repository.dart';
import 'package:classmate/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/streams.dart';

part 'school_state.dart';

class SchoolCubit extends Cubit<SchoolState> {
  final UserRepository _userRepository;

  SchoolCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SchoolState.initial()) {
    _userRepository.getCurrentUserData().then(
      (userData) {
        if (userData != null &&
            userData.registeredUnitIds != null &&
            userData.registeredUnitIds!.isNotEmpty &&
            userData.schoolId != null &&
            userData.sessionId != null) {
          userData.registeredUnitIds!.forEach(
            (unitId) async {
              UnitRepository unitRepository =
                  _createUnitRepository(unitId, userData);

              UnitModel unitDetails = await unitRepository.getUnitDetails();

              List<Stream<List<LessonModel>>> lessonsStreamList =
                  _generateLessonsStreamList(userData, unitDetails);

              List<Stream<List<AssignmentModel>>> assignmentsStreamList =
                  _generateAssignmentsStreamList(userData, unitDetails);

              emit(SchoolState.updated(
                lessonsStreamList: lessonsStreamList,
                assignmentsStreamList: assignmentsStreamList,
              ));
            },
          );
        }
      },
    );
  }

  UnitRepository _createUnitRepository(
    String unitId,
    UserDataModel userData,
  ) {
    var unitRepository = UnitRepository(
      unitId: unitId,
      schoolId: userData.schoolId!,
      sessionId: userData.sessionId!,
    );
    return unitRepository;
  }

  LessonRepository _createLessonRepository(
    UserDataModel userData,
    UnitModel unitDetails,
  ) {
    var lessonRepository = LessonRepository(
      userData.schoolId!,
      userData.sessionId!,
      unitDetails,
    );
    return lessonRepository;
  }

  AssignmentRepository _createAssignmentRepository(
    UserDataModel userData,
    UnitModel unitDetails,
  ) {
    var assignmentRepository = AssignmentRepository(
      userData.schoolId!,
      userData.sessionId!,
      unitDetails,
    );
    return assignmentRepository;
  }

  List<Stream<List<LessonModel>>> _generateLessonsStreamList(
    UserDataModel userData,
    UnitModel unitDetails,
  ) {
    LessonRepository lessonRepository = _createLessonRepository(
      userData,
      unitDetails,
    );

    var lessonStream = lessonRepository.lessonsDataStream;

    if (!state.lessonsStreamList.contains(lessonStream)) {
      List<Stream<List<LessonModel>>> newLessonsList =
          List.from(state.lessonsStreamList);
      newLessonsList.add(lessonStream);
      return newLessonsList;
    }

    return state.lessonsStreamList;
  }

  List<Stream<List<AssignmentModel>>> _generateAssignmentsStreamList(
    UserDataModel userData,
    UnitModel unitDetails,
  ) {
    AssignmentRepository assignmentRepository =
        _createAssignmentRepository(userData, unitDetails);

    var assignmentStream = assignmentRepository.assignmentsDataStream;

    if (!state.assignmentsStreamList.contains(assignmentStream)) {
      List<Stream<List<AssignmentModel>>> assignmentList =
          List.from(state.assignmentsStreamList);
      assignmentList.add(assignmentStream);
      return assignmentList;
    }

    return state.assignmentsStreamList;
  }

  Stream<List> getCombinedStreams() {
    List<Stream> comboList = List.from([
      ...state.lessonsStreamList,
      ...state.assignmentsStreamList,
    ]);
    return CombineLatestStream.list(comboList);
  }
}
