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
