part of 'assignments_bloc.dart';

class AssignmentsState extends Equatable {
  const AssignmentsState.initial({this.assignment});
  const AssignmentsState.created({this.assignment});
  const AssignmentsState.updated({required this.assignment});
  const AssignmentsState.deleted({required this.assignment});

  final Assignment? assignment;

  @override
  List<Object> get props => [assignment ?? 'No assignment added'];
}
