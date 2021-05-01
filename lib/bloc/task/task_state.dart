part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskAddedSuccessfully extends TaskState {
  final String title;
  final bool isDone;

  TaskAddedSuccessfully({required this.title, this.isDone = false});

  @override
  List<Object> get props => ["title : $title", "Done: $isDone"];
}

class TaskUpdatedSuccessfully extends TaskState {
  final TaskModel task;

  TaskUpdatedSuccessfully(this.task);

  @override
  List<Object> get props => [task];
}

class TaskDeletedSuccessfully extends TaskState {
  final TaskModel task;

  TaskDeletedSuccessfully(this.task);

  @override
  List<Object> get props => [task];
}
