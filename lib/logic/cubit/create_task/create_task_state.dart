part of 'create_task_cubit.dart';

class CreateTaskState extends Equatable {
  const CreateTaskState._({this.dueDate, this.taskType = 'Personal'});

  const CreateTaskState.changed({this.dueDate, required this.taskType});

  const CreateTaskState.initial() : this._();

  final DateTime? dueDate;
  final String taskType;

  @override
  List<Object> get props => [
        dueDate ?? 'No Due Date Set',
        'Task Type: $taskType',
      ];
}
