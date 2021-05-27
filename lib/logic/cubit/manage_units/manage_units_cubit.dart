import 'package:bloc/bloc.dart';
import '../../../data/models/unit_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/course_details_model.dart';
import '../../../data/models/school_model.dart';
import '../../../data/models/session_details_model.dart';
import '../../../data/models/user_data_model.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../navigation/navigation_cubit.dart';
import '../notification/notification_cubit.dart';
// import 'package:async/async.dart';

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

  // final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future<void> checkUserData() async {
    // return this._memoizer.runOnce(() async {
    return await _userRepository.getUserData().then((userData) async {
      if (!state.changed &&
          userData.schoolId != null &&
          userData.courseId != null &&
          userData.sessionId != null &&
          userData.year != null &&
          userData.semester != null &&
          userData.registeredUnitIds != null) {
        School school = await _getUserSchool(userData);
        CourseDetails course = school.courses!
            .firstWhere((element) => element.id == userData.courseId);
        SessionDetails session = school.sessions!
            .firstWhere((element) => element.id == userData.sessionId);
        String year = _mapYearToPrettyYear(userData.year!);
        String semester = _mapSemesterToPrettySemester(userData.semester!);

        emit(ManageUnitsState.changed(
          changed: false,
          school: school,
          course: course,
          semester: semester,
          session: session,
          year: year,
        ));
      }
    });
    // });
  }

  Future<List<School>> getListOfSchools() async {
    return await _schoolRepository.getAllSchools();
  }

  List<SessionDetails>? getListOfSessions() {
    return state.school?.sessions;
  }

  List<String>? getListOfYears() {
    return state.course?.units?.keys.map(_mapYearToPrettyYear).toList();
  }

  List<String>? getListOfSemesters() {
    return state.course?.units?[_mapPrettyYearToYear(state.year!)]?.keys
        .map(_mapSemesterToPrettySemester)
        .toList()
        .cast<String>();
  }

  List<UnitDetails?> getListOfUnits() {
    List unitIds = state.course?.units?[_mapPrettyYearToYear(state.year!)]
        ?[_mapPrettySemesterToSemester(state.semester!)];

    List<UnitDetails?> unitDetails = unitIds
        .map((unitId) =>
            state.school?.units?.firstWhere((unit) => unit.id == unitId))
        .toList();

    return unitDetails;
  }

  void changeSelectedSchool(School school) {
    return emit(ManageUnitsState.changed(school: school));
  }

  void changeSelectedCourse(CourseDetails course) {
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

  void changeSelectedSemester(String semester) {
    return emit(ManageUnitsState.changed(
      session: state.session,
      school: state.school,
      course: state.course,
      year: state.year,
      semester: semester,
    ));
  }

  void changeSelectedSession(SessionDetails session) {
    return emit(ManageUnitsState.changed(
      school: state.school,
      course: state.course,
      year: state.year,
      session: session,
    ));
  }

  Future<void> saveCourseDetailsToDatabase() async {
    try {
      _showSavingCourseDetailsNotification();

      await _userRepository
          .getUserData()
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
  Future<School> _getUserSchool(UserData userData) async {
    return await _schoolRepository.getSchoolDetailsFromID(userData.schoolId!);
  }

  // ## Notifications
  void _showSavingCourseDetailsNotification() {
    return _notificationCubit.showAlert(
      "Saving CourseDetails Details",
      type: NotificationType.Loading,
    );
  }

  void _showCourseDetailsSavedNotification() {
    return _notificationCubit.showAlert(
      "CourseDetails Details Saved",
      type: NotificationType.Success,
    );
  }

  void _showErrorSavingCourseDetailsNotification(String message) {
    _notificationCubit.showAlert(
      "Error Saving CourseDetails Details",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Saving CourseDetails Details",
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
      case 'year1':
        return 'First Year';
      case 'year2':
        return 'Second Year';
      case 'year3':
        return 'Third Year';
      case 'year4':
        return 'Fourth Year';
      case 'year5':
        return 'Fifth Year';
      case 'year6':
        return 'Sixth Year';
      default:
        this.addError(Exception("Undefined Year Found In Database"));
        throw Exception("Undefined Year Found In Database");
    }
  }

  /// ### Map Pretty Year To Year
  /// Converts the pretty year displayed to the user
  /// back to the year keys found on the firebase database
  /// e.g. => Year 1 -> year1
  String _mapPrettyYearToYear(String prettyYear) {
    switch (prettyYear) {
      case 'First Year':
        return 'year1';
      case 'Second Year':
        return 'year2';
      case 'Third Year':
        return 'year3';
      case 'Fourth Year':
        return 'year4';
      case 'Fifth Year':
        return 'year5';
      case 'Sixth Year':
        return 'year6';
      default:
        this.addError(Exception("Undefined Year Found In Database"));
        throw Exception("Undefined Year Found In Database");
    }
  }

  /// ### Map Semester To Pretty Semester
  /// Converts the semester keys in the firebase database to
  /// a prettier and more readable string
  /// e.g. => sem1 -> First Semester
  String _mapSemesterToPrettySemester(String semester) {
    switch (semester) {
      case 'sem1':
        return 'First Semester';
      case 'sem2':
        return 'Second Semester';
      case 'sem3':
        return 'Third Semester';
      default:
        this.addError(Exception("Undefined Semester Found In Database"));
        throw Exception("Undefined Semester Found In Database");
    }
  }

  /// ### Map Pretty Semester To Semester
  /// Converts the pretty semester displayed to the user
  /// back to the semester keys found on the firebase database
  /// e.g. => First Semester -> sem1
  String _mapPrettySemesterToSemester(String prettySemester) {
    switch (prettySemester) {
      case 'First Semester':
        return 'sem1';
      case 'Second Semester':
        return 'sem2';
      case 'Third Semester':
        return 'sem3';
      default:
        this.addError(Exception("Undefined Year Found In Database"));
        throw Exception("Undefined Year Found In Database");
    }
  }

  List<String>? _getListOfSelectedUnits() {
    return state
        .course
        ?.units?[_mapPrettyYearToYear(state.year!)]![
            _mapPrettySemesterToSemester(state.semester!)]
        .cast<String>();
  }

  UserData _updateUserData(UserData? currentUserData) {
    return currentUserData != null
        ? currentUserData.copyWith(
            schoolId: state.school!.id,
            courseId: state.course!.id,
            sessionId: state.session!.id,
            year: _mapPrettyYearToYear(state.year!),
            registeredUnitIds: _getListOfSelectedUnits(),
            semester: _mapPrettySemesterToSemester(state.semester!),
          )
        : UserData(
            schoolId: state.school!.id,
            courseId: state.course!.id,
            sessionId: state.session!.id,
            year: _mapPrettyYearToYear(state.year!),
            registeredUnitIds: _getListOfSelectedUnits(),
            semester: _mapPrettySemesterToSemester(state.semester!),
          );
  }
}
