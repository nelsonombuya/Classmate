part of 'create_assignment_cubit.dart';

class CreateAssignmentState extends Equatable {
  const CreateAssignmentState.initial({
    required this.selectedDueDate,
    this.unit,
  });

  const CreateAssignmentState.changed({
    required this.selectedDueDate,
    required this.unit,
  });

  final UnitDetails? unit;
  final DateTime selectedDueDate;

  @override
  List<Object> get props => ["Due Date: $selectedDueDate"];
}
