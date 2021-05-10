part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState.initial({this.task = TaskModel.empty});

  const TasksState.created(this.task);

  const TasksState.updated(this.task);

  const TasksState.deleted(this.task);

  final TaskModel task;

  @override
  List<Object> get props => [task];
}
