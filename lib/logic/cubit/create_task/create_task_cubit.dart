import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/task_model.dart';
import 'package:classmate/logic/bloc/tasks/tasks_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({required TasksBloc tasksBloc})
      : _tasksBloc = tasksBloc,
        super(CreateTaskState.initial());

  final formKey = GlobalKey<FormState>();
  final nakuru = LatLng(0, 0);
  final taskTitleController = TextEditingController();
  final taskTypes = <String>['Personal', 'Work', 'School'];

  final TasksBloc _tasksBloc;

  changeSelectedDueDate(DateTime date) {
    return emit(CreateTaskState.changed(
      dueDate: date,
      taskType: state.taskType,
    ));
  }

  changeSelectedTaskType(String taskType) {
    return emit(CreateTaskState.changed(
      dueDate: state.dueDate,
      taskType: taskType,
    ));
  }

  Future<LatLng> getCurrentLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) => position);
    return LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  setTaskDetails(TaskModel task) {
    taskTitleController.text = task.title;
    return emit(CreateTaskState.changed(
      taskType: task.type,
      dueDate: task.dueDate,
    ));
  }

  saveTask(TaskModel? task) {
    if (formKey.currentState!.validate()) {
      return task != null
          ? _tasksBloc.add(
              PersonalTaskUpdated(
                task.copyWith(
                    type: state.taskType,
                    dueDate: state.dueDate,
                    title: taskTitleController.text.trim()),
                popCurrentPage: true,
              ),
            )
          : _tasksBloc.add(
              PersonalTaskCreated(
                dueDate: state.dueDate,
                taskType: state.taskType,
                title: taskTitleController.text.trim(),
              ),
            );
    }
  }
}
