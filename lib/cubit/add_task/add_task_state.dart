part of 'add_task_cubit.dart';

abstract class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

class AddTaskInitial extends AddTaskState {}

class TaskValidation extends AddTaskState {}
