part of 'create_lesson_cubit.dart';

class CreateLessonState extends Equatable {
  const CreateLessonState.changed({
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.unit,
  });

  const CreateLessonState.initial({
    required this.selectedStartDate,
    required this.selectedEndDate,
    this.unit,
  });

  final DateTime selectedEndDate;
  final DateTime selectedStartDate;
  final UnitDetails? unit;

  @override
  List<Object> get props => [
        "Start Date: $selectedStartDate",
        "End Date: $selectedEndDate",
      ];
}
