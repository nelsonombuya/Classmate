part of 'create_lesson_cubit.dart';

class CreateLessonState extends Equatable {
  const CreateLessonState.changed({
    required this.setForAllLessons,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.unit,
  });

  const CreateLessonState.initial({
    required this.setForAllLessons,
    required this.selectedStartDate,
    required this.selectedEndDate,
    this.unit,
  });

  final DateTime selectedEndDate;
  final DateTime selectedStartDate;
  final bool setForAllLessons;
  final UnitDetails? unit;

  @override
  List<Object> get props => [
        "Start Date: $selectedStartDate",
        "End Date: $selectedEndDate",
        "Set for All Lessons: $setForAllLessons",
        "Unit: ${unit?.name}"
      ];
}
