part of 'create_task_cubit.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object> get props => [];
}

class CreateTaskInitial extends CreateTaskState {}

class TaskValidation extends CreateTaskState {}
