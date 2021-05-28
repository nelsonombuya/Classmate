part of 'lessons_bloc.dart';

class LessonsState extends Equatable {
  const LessonsState.initial({this.lesson});
  const LessonsState.created({this.lesson});
  const LessonsState.updated({required this.lesson});
  const LessonsState.deleted({required this.lesson});

  final Lesson? lesson;

  @override
  List<Object> get props => [lesson ?? 'No lesson added'];
}
