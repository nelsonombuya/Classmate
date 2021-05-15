part of 'school_cubit.dart';

class SchoolState extends Equatable {
  const SchoolState._({this.lessonsStream = const []});

  const SchoolState.initial() : this._();

  const SchoolState.updated({required this.lessonsStream});

  final List<Stream<List<LessonModel>>> lessonsStream;

  @override
  List<Object> get props => [lessonsStream];
}
