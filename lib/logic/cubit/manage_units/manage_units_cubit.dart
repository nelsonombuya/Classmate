import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/course_model.dart';
import '../../../data/models/school_model.dart';
import '../../../data/models/session_model.dart';
import '../../../data/models/user_data_model.dart';
import '../../../data/repositories/courses_repository.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/sessions_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../navigation/navigation_cubit.dart';
import '../notification/notification_cubit.dart';

part 'manage_units_state.dart';

class ManageUnitsCubit extends Cubit<ManageUnitsState> {
  ManageUnitsCubit({
    required UserRepository userRepository,
    required SchoolRepository schoolRepository,
    required NavigationCubit navigationCubit,
    required NotificationCubit notificationCubit,
  })   : _userRepository = userRepository,
        _schoolRepository = schoolRepository,
        _navigationCubit = navigationCubit,
        _notificationCubit = notificationCubit,
        super(ManageUnitsState.initial());

  final NavigationCubit _navigationCubit;
  final NotificationCubit _notificationCubit;

  final UserRepository _userRepository;
  final SchoolRepository _schoolRepository;

  late CourseRepository _courseRepository;
  late SessionRepository _sessionRepository;

  Future<void> checkUserData() async {
    return await _userRepository.getCurrentUserData().then((userData) async {
      if (!state.changed &&
          userData?.schoolId != null &&
          userData?.courseId != null &&
          userData?.sessionId != null &&
          userData?.year != null &&
          userData?.registeredUnitIds != null) {
        SchoolModel school = await _getUserSchool(userData!);
        CourseModel course = await _getUserCourse(userData, school);
        SessionModel session = await _getUserSession(userData, school);
        String year = _mapYearToPrettyYear(userData.year!);
        emit(ManageUnitsState.changed(
          changed: false,
          school: school,
          course: course,
          session: session,
          year: year,
        ));
      }
    });
  }

  Future<List<SchoolModel>> getListOfSchools() async {
    return await _schoolRepository.getAllSchools();
  }

  Future<List<CourseModel>> getListOfCourses() async {
    _initializeCourseRepository(state.school!);
    return await _courseRepository.getAllCourses();
  }

  Future<List<SessionModel>> getListOfSessions() async {
    _initializeSessionRepository(state.school!);
    return await _sessionRepository.getAllSessions();
  }

  Future<List<String>> getListOfYears() async {
    return await _courseRepository
        .getCourseDetails(state.course!)
        .then((course) => course.units.keys.map(_mapYearToPrettyYear).toList());
  }

  Future<List> getListOfUnits() async {
    return await _courseRepository
        .getCourseDetails(state.course!)
        .then((course) => course.units[_mapPrettyYearToYear(state.year!)]);
  }

  void changeSelectedSchool(SchoolModel school) {
    return emit(ManageUnitsState.changed(school: school));
  }

  void changeSelectedCourse(CourseModel course) {
    return emit(ManageUnitsState.changed(
      school: state.school,
      course: course,
    ));
  }

  void changeSelectedYear(String year) {
    return emit(ManageUnitsState.changed(
      session: state.session,
      school: state.school,
      course: state.course,
      year: year,
    ));
  }

  void changeSelectedSession(SessionModel session) {
    return emit(ManageUnitsState.changed(
      school: state.school,
      course: state.course,
      year: state.year,
      session: session,
    ));
  }

  void _initializeCourseRepository(SchoolModel school) {
    _courseRepository = CourseRepository(school);
  }

  void _initializeSessionRepository(SchoolModel school) {
    _sessionRepository = SessionRepository(school);
  }

  Future<void> saveCourseDetailsToDatabase() async {
    try {
      _showSavingCourseDetailsNotification();

      await _userRepository
          .getCurrentUserData()
          .then((userData) => _updateUserData(userData))
          .then((newUserData) => _userRepository.setUserData(newUserData));

      _showCourseDetailsSavedNotification();
      _navigationCubit.popCurrentPage();
    } catch (e) {
      _showErrorSavingCourseDetailsNotification(e.toString());
      this.addError(e);
    }
  }

  // ### Getting User Data
  Future<SchoolModel> _getUserSchool(UserDataModel userData) async {
    return await _schoolRepository.getSchoolDetailsFromID(userData.schoolId!);
  }

  Future<CourseModel> _getUserCourse(
    UserDataModel userData,
    SchoolModel school,
  ) async {
    _initializeCourseRepository(school);
    return await _courseRepository.getCourseDetailsFromID(userData.courseId!);
  }

  Future<SessionModel> _getUserSession(
    UserDataModel userData,
    SchoolModel school,
  ) async {
    _initializeSessionRepository(school);
    return await _sessionRepository
        .getSessionDetailsFromID(userData.sessionId!);
  }

  // ## Notifications
  void _showSavingCourseDetailsNotification() {
    return _notificationCubit.showAlert(
      "Saving Course Details",
      type: NotificationType.Loading,
    );
  }

  void _showCourseDetailsSavedNotification() {
    return _notificationCubit.showAlert(
      "Course Details Saved",
      type: NotificationType.Success,
    );
  }

  void _showErrorSavingCourseDetailsNotification(String message) {
    _notificationCubit.showAlert(
      "Error Saving Course Details",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Saving Course Details",
      type: NotificationType.Danger,
    );
  }

  /// ## Mappers
  /// ### Map Year To Pretty Year
  /// Converts the year keys in the firebase database to
  /// a prettier and more readable string
  /// e.g. => year1 -> Year 1
  String _mapYearToPrettyYear(String year) {
    switch (year) {
      case 'firstYear':
        return 'First Year';
      case 'secondYear':
        return 'Second Year';
      case 'thirdYear':
        return 'Third Year';
      case 'fourthYear':
        return 'Fourth Year';
      case 'fifthYear':
        return 'Fifth Year';
      case 'sixthYear':
        return 'Sixth Year';
      default:
        this.addError(Exception("Undefined Year Found In Database"));
        throw Exception("Undefined Year Found In Database");
    }
  }

  /// ### Map Pretty Year To Year
  /// Converts the pretty year displayed to the user
  /// back to the year keys found on the firebase database
  /// for data integrity
  String _mapPrettyYearToYear(String prettyYear) {
    switch (prettyYear) {
      case 'First Year':
        return 'firstYear';
      case 'Second Year':
        return 'secondYear';
      case 'Third Year':
        return 'thirdYear';
      case 'Fourth Year':
        return 'fourthYear';
      case 'Fifth Year':
        return 'fifthYear';
      case 'Sixth Year':
        return 'sixthYear';
      default:
        this.addError(Exception("Undefined Year Found In Database"));
        throw Exception("Undefined Year Found In Database");
    }
  }

  List<String> _getListOfSelectedUnits() {
    return List<String>.from(state
        .course!.units[_mapPrettyYearToYear(state.year!)]
        .map((unit) => unit['id'])
        .toList());
  }

  UserDataModel _updateUserData(UserDataModel? currentUserData) {
    return currentUserData != null
        ? currentUserData.copyWith(
            privilege: 'student',
            schoolId: state.school!.id,
            courseId: state.course!.id,
            sessionId: state.session!.id,
            year: _mapPrettyYearToYear(state.year!),
            registeredUnitIds: _getListOfSelectedUnits(),
          )
        : UserDataModel(
            privilege: 'student',
            schoolId: state.school!.id,
            courseId: state.course!.id,
            sessionId: state.session!.id,
            year: _mapPrettyYearToYear(state.year!),
            registeredUnitIds: _getListOfSelectedUnits(),
          );
  }
}
