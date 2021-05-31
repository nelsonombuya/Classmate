part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class PersonalTaskCreated extends TasksEvent {
  const PersonalTaskCreated({
    this.dueDate,
    this.isDone = false,
    required this.title,
    required this.taskType,
  });

  final DateTime? dueDate;
  final bool isDone;
  final String taskType;
  final String title;

  @override
  List<Object> get props => [
        "Title : $title",
        "Is Done: $isDone",
        "Due Date: $dueDate",
        "Task Type: $taskType",
      ];
}

abstract class ExistingTask extends TasksEvent {
  const ExistingTask(this.task);

  final TaskModel task;

  @override
  List<Object> get props => [task];
}

class PersonalTaskUpdated extends ExistingTask {
  const PersonalTaskUpdated(
    this.task, {
    this.silentUpdate = false,
    this.popCurrentPage = false,
  }) : super(task);

  final bool popCurrentPage;
  final bool silentUpdate;
  final TaskModel task;

  @override
  List<Object> get props => [task];
}

class PersonalTaskDeleted extends ExistingTask {
  const PersonalTaskDeleted(this.task) : super(task);

  final TaskModel task;

  @override
  List<Object> get props => [task];
}
