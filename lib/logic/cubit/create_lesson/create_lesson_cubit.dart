import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/unit_model.dart';
import 'package:classmate/logic/bloc/lessons/lessons_bloc.dart';
import '../../../constants/validator.dart';
import '../../../data/models/unit_details_model.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../bloc/lessons/lessons_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

part 'create_lesson_state.dart';

class CreateLessonCubit extends Cubit<CreateLessonState> {
  CreateLessonCubit({
    required SchoolRepository schoolRepository,
    required UserRepository userRepository,
    required LessonsBloc lessonsBloc,
  })  : _userRepository = userRepository,
        _lessonsBloc = lessonsBloc,
        _schoolRepository = schoolRepository,
        super(CreateLessonState.initial(
            setForAllLessons: true,
            selectedStartDate: DateTime.now(),
            selectedEndDate: DateTime.now().add(Duration(hours: 2))));

  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final titleValidator = Validator.titleValidator;

  final LessonsBloc _lessonsBloc;
  final AsyncMemoizer<List<UnitDetails?>> _memoizer = AsyncMemoizer();
  final SchoolRepository _schoolRepository;
  final UserRepository _userRepository;

  Future<List<UnitDetails?>> _getListOfRegisteredUnits() async {
    var userData = await _userRepository.getUserData();
    if (userData.registeredUnitIds == null && userData.schoolId == null)
      return [];

    var registeredUnitIds = userData.registeredUnitIds!;
    var schoolDetails =
        await _schoolRepository.getSchoolDetailsFromID(userData.schoolId!);

    List<UnitDetails?> unitDetails = registeredUnitIds
        .map((unitId) => schoolDetails.units
            ?.firstWhere((unitDetails) => unitDetails.id == unitId))
        .toList();

    return unitDetails;
  }

  void changeSelectedEndDate(DateTime selectedEndDate) {
    return emit(CreateLessonState.changed(
      setForAllLessons: state.setForAllLessons,
      selectedStartDate: state.selectedStartDate,
      selectedEndDate: selectedEndDate,
      unit: state.unit,
    ));
  }

  void changeSelectedStartDate(DateTime selectedStartDate) {
    return emit(CreateLessonState.changed(
      setForAllLessons: state.setForAllLessons,
      selectedStartDate: selectedStartDate,
      selectedEndDate: state.selectedEndDate,
      unit: state.unit,
    ));
  }

  void changeSelectedUnit(UnitDetails unit) {
    return emit(CreateLessonState.changed(
      setForAllLessons: state.setForAllLessons,
      selectedStartDate: state.selectedStartDate,
      selectedEndDate: state.selectedEndDate,
      unit: unit,
    ));
  }

  void changeSetForAllLessons(bool value) {
    return emit(CreateLessonState.changed(
      selectedStartDate: state.selectedStartDate,
      selectedEndDate: state.selectedEndDate,
      setForAllLessons: value,
      unit: state.unit,
    ));
  }

  Future<List<UnitDetails?>> getRegisteredUnits() {
    return _memoizer.runOnce(_getListOfRegisteredUnits);
  }

  void saveLesson() {
    if (formKey.currentState?.validate() ?? false) {
      _lessonsBloc.add(LessonCreated(
        duplicate: state.setForAllLessons,
        description: descriptionController.text,
        startDate: state.selectedStartDate,
        endDate: state.selectedEndDate,
        title: titleController.text,
        unit: state.unit!,
      ));
    }
  }

  void setLessonDetails(Lesson lesson, Unit unit) {
    titleController.text = lesson.title;
    if (lesson.description != null)
      descriptionController.text = lesson.description!;

    return emit(CreateLessonState.changed(
      setForAllLessons: false,
      selectedStartDate: lesson.startDate,
      selectedEndDate: lesson.endDate,
      unit: unit.unitDetails,
    ));
  }

  void updateLesson(Unit unit, Lesson lesson, int index) {
    if (formKey.currentState?.validate() ?? false) {
      var newLesson = lesson.copyWith(
        description: descriptionController.text,
        startDate: state.selectedStartDate,
        endDate: state.selectedEndDate,
        title: titleController.text,
      );
      unit.lessons![index] = newLesson;
      _lessonsBloc.add(LessonUpdated(lesson: lesson, unit: unit));
    }
  }
}
