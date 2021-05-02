part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class PersonalTaskCreated extends TaskEvent {
  final String title;
  final bool isDone;

  PersonalTaskCreated({required this.title, this.isDone = false});

  @override
  List<Object> get props => ["title : $title", "Done: $isDone"];
}

class PersonalTaskUpdated extends TaskEvent {
  final TaskModel task;

  PersonalTaskUpdated(this.task);

  @override
  List<Object> get props => [task];
}

class PersonalTaskDeleted extends TaskEvent {
  final TaskModel task;

  PersonalTaskDeleted(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskConfirmed extends TaskEvent {
  final TaskModel task;

  DeleteTaskConfirmed(this.task);

  @override
  List<Object> get props => [task];
}
