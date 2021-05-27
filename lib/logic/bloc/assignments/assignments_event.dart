part of 'assignments_bloc.dart';

abstract class AssignmentsEvent extends Equatable {
  const AssignmentsEvent();

  @override
  List<Object> get props => [];
}

class AssignmentCreated extends AssignmentsEvent {
  const AssignmentCreated({
    required this.title,
    required this.dueDate,
    required this.unit,
    this.description,
  });

  final String title;
  final DateTime dueDate;
  final String? description;
  final UnitDetails unit;
}

abstract class ExistingAssignment extends AssignmentsEvent {
  const ExistingAssignment({required this.assignment, required this.unit});

  final Assignment assignment;
  final Unit unit;

  @override
  List<Object> get props => [assignment, unit.id ?? "No Unit ID Set"];
}

class AssignmentUpdated extends ExistingAssignment {
  const AssignmentUpdated({
    required this.unit,
    required this.assignment,
    this.silentUpdate = false,
  }) : super(assignment: assignment, unit: unit);

  final Unit unit;
  final bool silentUpdate;
  final Assignment assignment;

  @override
  List<Object> get props => [assignment, unit.id ?? 'No Unit ID Set'];
}

class AssignmentDeleted extends ExistingAssignment {
  const AssignmentDeleted({
    required this.assignment,
    required this.unit,
  }) : super(assignment: assignment, unit: unit);

  final Assignment assignment;
  final Unit unit;

  @override
  List<Object> get props => [assignment, unit.id ?? 'No Unit ID Set'];
}
