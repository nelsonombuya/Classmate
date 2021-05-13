import 'package:bloc/bloc.dart';
import 'package:classmate/cubit/navigation/navigation_cubit.dart';
import 'package:classmate/cubit/notification/notification_cubit.dart';
import 'package:classmate/data/models/course_model.dart';
import 'package:classmate/data/models/school_model.dart';
import 'package:classmate/data/models/user_data_model.dart';
import 'package:classmate/data/repositories/courses_repository.dart';
import 'package:classmate/data/repositories/school_repository.dart';
import 'package:classmate/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'manage_units_state.dart';

class ManageUnitsCubit extends Cubit<ManageUnitsState> {
  ManageUnitsCubit({
    required SchoolRepository schoolRepository,
    required UserRepository userRepository,
    required NotificationCubit notificationCubit,
    required NavigationCubit navigationCubit,
  })   : _schoolRepository = schoolRepository,
        _userRepository = userRepository,
        _notificationCubit = notificationCubit,
        _navigationCubit = navigationCubit,
        super(ManageUnitsState.initial());

  late CourseRepository _courseRepository;

  final SchoolRepository _schoolRepository;
  final UserRepository _userRepository;
  final NotificationCubit _notificationCubit;
  final NavigationCubit _navigationCubit;

  Future<void> checkUserData() async {
    return await _userRepository.getUserData().then((userData) async {
      if (!state.changed &&
          userData?.school != null &&
          userData?.course != null &&
          userData?.year != null &&
          userData?.registeredUnits != null) {
        SchoolModel school = await _getUserSchool(userData!);
        CourseModel course = await _getUserCourse(userData, school);
        String year = _mapYearKeysToString(userData.year!);
        emit(ManageUnitsState.changed(
          changed: false,
          school: school,
          course: course,
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

  Future<List<String>> getListOfYears() async {
    return await _courseRepository
        .getCourseDetails(state.course!)
        .then((course) => course.units.keys.map(_mapYearKeysToString).toList());
  }

  Future<List> getListOfUnits() async {
    return await _courseRepository
        .getCourseDetails(state.course!)
        .then((course) => course.units[_mapYearStringToKey(state.year!)]);
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
      school: state.school,
      course: state.course,
      year: year,
    ));
  }

  void _initializeCourseRepository(SchoolModel school) {
    _courseRepository = CourseRepository(school);
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
  Future<SchoolModel> _getUserSchool(UserDataModel userData) async {
    return await _schoolRepository.getSchoolDetailsFromID(userData.school!);
  }

  Future<CourseModel> _getUserCourse(
    UserDataModel userData,
    SchoolModel school,
  ) async {
    _initializeCourseRepository(school);
    return await _courseRepository.getCourseDetailsFromID(userData.course!);
  }

  // ### Notifications
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

  // ### Mappers
  String _mapYearKeysToString(String key) {
    switch (key) {
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

  String _mapYearStringToKey(String year) {
    switch (year) {
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
        .course!.units[_mapYearStringToKey(state.year!)]
        .map((unit) => unit['code'])
        .toList());
  }

  UserDataModel _updateUserData(UserDataModel? currentUserData) {
    return currentUserData != null
        ? currentUserData.copyWith(
            school: state.school!.id,
            course: state.course!.id,
            year: _mapYearStringToKey(state.year!),
            registeredUnits: _getListOfSelectedUnits(),
          )
        : UserDataModel(
            school: state.school!.id,
            course: state.course!.id,
            year: _mapYearStringToKey(state.year!),
            registeredUnits: _getListOfSelectedUnits(),
          );
  }
}
