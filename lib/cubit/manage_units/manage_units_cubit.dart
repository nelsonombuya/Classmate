import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/course_model.dart';
import 'package:classmate/data/models/school_model.dart';
import 'package:classmate/data/repositories/courses_repository.dart';
import 'package:classmate/data/repositories/school_repository.dart';
import 'package:equatable/equatable.dart';

part 'manage_units_state.dart';

class ManageUnitsCubit extends Cubit<ManageUnitsState> {
  ManageUnitsCubit({required SchoolRepository schoolRepository})
      : _schoolRepository = schoolRepository,
        super(ManageUnitsState.initial());

  final SchoolRepository _schoolRepository;
  late CourseRepository _courseRepository;

  Future<List<SchoolModel>> getListOfSchools() async {
    return await _schoolRepository.getAllSchools();
  }

  Future<List<CourseModel>> getListOfCourses() async {
    _initializeCourseRepository();
    return await _courseRepository.getAllCourses();
  }

  Future<List<String>> getListOfYears() async {
    return await _courseRepository
        .getCourseDetails(state.course!)
        .then((course) => course.units.keys.map(_mapYearKeysToString).toList());
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

  void _initializeCourseRepository() {
    _courseRepository = CourseRepository(state.school!);
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
}
