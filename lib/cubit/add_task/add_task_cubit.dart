import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  void validateNewTask() => emit(TaskValidation());
}
