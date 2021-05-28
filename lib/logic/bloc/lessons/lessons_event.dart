part of 'lessons_bloc.dart';

abstract class LessonsEvent extends Equatable {
  const LessonsEvent();

  @override
  List<Object> get props => [];
}

class LessonCreated extends LessonsEvent {
  const LessonCreated({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.unit,
    required this.duplicate,
    this.description,
  });

  final String? description;
  final bool duplicate;
  final DateTime endDate;
  final DateTime startDate;
  final String title;
  final UnitDetails unit;
}

abstract class ExistingLesson extends LessonsEvent {
  const ExistingLesson({required this.lesson, required this.unit});

  final Lesson lesson;
  final Unit unit;

  @override
  List<Object> get props => [lesson, unit.id ?? "No Unit ID Set"];
}

class LessonUpdated extends ExistingLesson {
  const LessonUpdated({
    required this.unit,
    required this.lesson,
  }) : super(lesson: lesson, unit: unit);

  final Lesson lesson;
  final Unit unit;

  @override
  List<Object> get props => [lesson, unit.id ?? 'No Unit ID Set'];
}

class LessonDeleted extends ExistingLesson {
  const LessonDeleted({
    required this.lesson,
    required this.unit,
  }) : super(lesson: lesson, unit: unit);

  final Lesson lesson;
  final Unit unit;

  @override
  List<Object> get props => [lesson, unit.id ?? 'No Unit ID Set'];
}
