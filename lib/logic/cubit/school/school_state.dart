part of 'school_cubit.dart';

class SchoolState extends Equatable {
  const SchoolState._({
    this.lessonsStreamList = const [],
    this.assignmentsStreamList = const [],
  });

  const SchoolState.initial() : this._();

  const SchoolState.updated({
    required this.lessonsStreamList,
    required this.assignmentsStreamList,
  });

  final List<Stream<List<LessonModel>>> lessonsStreamList;
  final List<Stream<List<AssignmentModel>>> assignmentsStreamList;

  @override
  List<Object> get props => [lessonsStreamList, assignmentsStreamList];
}
