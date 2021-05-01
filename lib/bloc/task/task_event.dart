part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class NewPersonalTaskAdded extends TaskEvent {
  final String title;
  final bool isDone;

  NewPersonalTaskAdded({required this.title, this.isDone = false});

  @override
  List<Object> get props => ["title : $title", "Done: $isDone"];
}
