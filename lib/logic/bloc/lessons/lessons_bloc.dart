import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/user_data_model.dart';
import 'package:classmate/data/repositories/school_repository.dart';
import '../../../data/models/lesson_model.dart';
import '../../../data/models/unit_details_model.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/repositories/unit_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../cubit/navigation/navigation_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';
import 'package:equatable/equatable.dart';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  LessonsBloc({
    required NotificationCubit notificationCubit,
    required NavigationCubit navigationCubit,
    required UserRepository userRepository,
  })  : _notificationCubit = notificationCubit,
        _navigationCubit = navigationCubit,
        _userRepository = userRepository,
        super(LessonsState.initial());

  final NavigationCubit _navigationCubit;
  final NotificationCubit _notificationCubit;
  final UserRepository _userRepository;

  @override
  Stream<LessonsState> mapEventToState(LessonsEvent event) async* {
    if (event is LessonCreated) {
      yield* _mapLessonCreatedToState(event);
    } else if (event is LessonUpdated) {
      yield* _mapLessonUpdatedToState(event);
    } else if (event is LessonDeleted) {
      yield* _mapLessonDeletedToState(event);
    }
  }

  Future<void> _addDuplicatedLessons(
    UserData userData,
    Unit currentUnitDetails,
    Lesson lesson,
  ) async {
    var schoolDetails =
        await SchoolRepository().getSchoolDetailsFromID(userData.schoolId!);
    var sessionDetails = schoolDetails.sessions!
        .firstWhere((element) => element.id == userData.sessionId!);

    final numberOfWeeks = _weeksBetween(
      sessionDetails.startDate!,
      sessionDetails.endDate!,
    );

    for (int i = 0; i < numberOfWeeks; ++i) {
      currentUnitDetails.lessons!.add(lesson);
      lesson = lesson.copyWith(
        startDate: lesson.startDate.add(Duration(days: 7)),
        endDate: lesson.endDate.add(Duration(days: 7)),
      );
    }
  }

  Future<Unit> _getUnitDetails(
    UnitRepository unitRepository,
    LessonCreated event,
    String sessionID,
  ) async {
    return await unitRepository.getUnit(event.unit.id) ??
        Unit(
          id: event.unit.id,
          unitDetails: event.unit,
          sessionId: sessionID,
          assignments: [],
          lessons: [],
        );
  }

  Future<UnitRepository> _getUnitRepository() async {
    var userData = await _userRepository.getUserData();
    var unitRepository = UnitRepository(
      schoolID: userData.schoolId!,
      sessionID: userData.sessionId!,
    );
    return unitRepository;
  }

  Lesson _mapEventToLesson(LessonCreated event) {
    return Lesson(
      description: event.description,
      startDate: event.startDate,
      endDate: event.endDate,
      title: event.title,
    );
  }

  Stream<LessonsState> _mapLessonCreatedToState(LessonCreated event) async* {
    try {
      _showCreatingLessonNotification();
      var lesson = _mapEventToLesson(event);
      var userData = await _userRepository.getUserData();
      var unitRepository = UnitRepository(
        schoolID: userData.schoolId!,
        sessionID: userData.sessionId!,
      );
      Unit currentUnitDetails = await _getUnitDetails(
        unitRepository,
        event,
        userData.sessionId!,
      );

      if (event.duplicate) {
        await _addDuplicatedLessons(userData, currentUnitDetails, lesson);
      } else {
        currentUnitDetails.lessons!.add(lesson);
      }

      await unitRepository.updateUnit(currentUnitDetails);
      _showLessonCreatedSuccessfullyNotification();
      _navigationCubit.popCurrentPage();
      yield LessonsState.updated(lesson: lesson);
    } catch (e) {
      _showErrorCreatingLessonNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<LessonsState> _mapLessonDeletedToState(LessonDeleted event) async* {
    try {
      _showDeletingLessonNotification();
      UnitRepository unitRepository = await _getUnitRepository();
      await unitRepository.updateUnit(event.unit);
      _showLessonDeletedSuccessfullyNotification();
      yield LessonsState.deleted(lesson: event.lesson);
    } catch (e) {
      _showErrorDeletingLessonNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<LessonsState> _mapLessonUpdatedToState(LessonUpdated event) async* {
    try {
      _showUpdatingLessonNotification();
      UnitRepository unitRepository = await _getUnitRepository();
      await unitRepository.updateUnit(event.unit);
      _showLessonUpdatedSuccessfullyNotification();
      _navigationCubit.popCurrentPage();
      yield LessonsState.updated(lesson: event.lesson);
    } catch (e) {
      _showErrorUpdatingLessonNotification(e.toString());
      this.addError(e);
    }
  }

  // ## Notifications
  void _showCreatingLessonNotification() {
    return _notificationCubit.showAlert(
      "Creating Lesson",
      type: NotificationType.Loading,
    );
  }

  void _showDeletingLessonNotification() {
    return _notificationCubit.showAlert(
      "Deleting Lesson",
      type: NotificationType.Loading,
    );
  }

  void _showErrorCreatingLessonNotification(String message) {
    _notificationCubit.showAlert(
      "Error Creating Lesson",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Creating Lesson",
      type: NotificationType.Danger,
    );
  }

  void _showErrorDeletingLessonNotification(String message) {
    _notificationCubit.showAlert(
      "Error Deleting Lesson",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Deleting Lesson",
      type: NotificationType.Danger,
    );
  }

  void _showErrorUpdatingLessonNotification(String message) {
    _notificationCubit.showAlert(
      "Error Updating Lesson",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Updating Lesson",
      type: NotificationType.Danger,
    );
  }

  void _showLessonCreatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Lesson Created",
      type: NotificationType.Success,
    );
  }

  void _showLessonDeletedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Lesson Deleted",
      type: NotificationType.Success,
    );
  }

  void _showLessonUpdatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Lesson Updated",
      type: NotificationType.Success,
    );
  }

  void _showUpdatingLessonNotification() {
    return _notificationCubit.showAlert(
      "Updating Lesson",
      type: NotificationType.Loading,
    );
  }

  int _weeksBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).round();
  }
}
