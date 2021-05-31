part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class PersonalTaskCreated extends TasksEvent {
  const PersonalTaskCreated({required this.title, this.isDone = false});

  final String title;
  final bool isDone;

  @override
  List<Object> get props => ["Title : $title", "Is Done: $isDone"];
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

  final TaskModel task;
  final bool silentUpdate;
  final bool popCurrentPage;

  @override
  List<Object> get props => [task];
}

class PersonalTaskDeleted extends ExistingTask {
  const PersonalTaskDeleted(this.task) : super(task);

  final TaskModel task;

  @override
  List<Object> get props => [task];
}
