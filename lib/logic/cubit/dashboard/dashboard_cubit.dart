import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/assignment_model.dart';
import 'package:classmate/logic/bloc/assignments/assignments_bloc.dart';
import 'package:classmate/logic/bloc/lessons/lessons_bloc.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/models/user_data_model.dart';
import '../../../data/repositories/unit_repository.dart';
import '../../../data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:async/async.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(UserRepository userRepository, AssignmentsBloc assignmentsBloc,
      LessonsBloc lessonsBloc)
      : _lessonsBloc = lessonsBloc,
        _userRepository = userRepository,
        _assignmentsBloc = assignmentsBloc,
        super(DashboardInitial());

  final AssignmentsBloc _assignmentsBloc;
  final LessonsBloc _lessonsBloc;
  final _memoizer = AsyncMemoizer<List<Stream<Unit?>>>();
  final UserRepository _userRepository;

  Future<List<Stream<Unit?>>> _getListOfUnitStreams() async {
    UserData userData = await _userRepository.getUserData();

    if (userData.schoolId == null ||
        userData.sessionId == null ||
        userData.registeredUnitIds == null ||
        userData.registeredUnitIds!.isEmpty) return [];

    var unitRepository = UnitRepository(
      schoolID: userData.schoolId!,
      sessionID: userData.sessionId!,
    );

    return userData.registeredUnitIds
            ?.map((element) => unitRepository.getUnitsStream(element))
            .toList() ??
        [];
  }

  deleteAssignment({required Unit unit, required int index}) {
    return _assignmentsBloc.add(AssignmentDeleted(
      assignment: unit.assignments!.removeAt(index),
      unit: unit,
    ));
  }

  deleteLesson({required Unit unit, required int index}) {
    return _lessonsBloc.add(LessonDeleted(
      lesson: unit.lessons!.removeAt(index),
      unit: unit,
    ));
  }

  Future<List<Stream<Unit?>>> getStreams() async =>
      await _memoizer.runOnce(_getListOfUnitStreams);

  toggleAssignmentAsDone({
    required String uid,
    required Unit unit,
    required bool isDone,
    required Assignment assignment,
    required int index,
  }) {
    try {
      unit.assignments![index].isDone!.update(uid, (value) => isDone);
    } on ArgumentError {
      unit.assignments![index].isDone!.putIfAbsent(uid, () => isDone);
    } finally {
      _assignmentsBloc.add(AssignmentUpdated(
        assignment: assignment.copyWith(isDone: {uid: isDone}),
        silentUpdate: true,
        unit: unit,
      ));
    }
  }
}
