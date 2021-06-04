import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/models/task_model.dart';
import '../../bloc/tasks/tasks_bloc.dart';
import '../location/location_cubit.dart';

part 'tasks_page_state.dart';

class TasksPageCubit extends Cubit<TasksPageState> {
  TasksPageCubit({
    required TasksBloc tasksBloc,
    required LocationCubit locationCubit,
  })  : _tasksBloc = tasksBloc,
        _locationCubit = locationCubit,
        super(TasksPageInitial());

  final LocationCubit _locationCubit;

  final TasksBloc _tasksBloc;

  Future<String> getDistanceFromMyCurrentLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      // * Using last known position because it's faster
      var currentLocation =
          await _locationCubit.getUserLatLngWithTimeout(Duration(seconds: 10));

      if (currentLocation == null) throw NullThrownError();

      var distanceInMeters = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        latitude,
        longitude,
      );

      return distanceInMeters > 1000
          ? "${(distanceInMeters / 1000).round()} KM Away"
          : "${distanceInMeters.round()} Meters Away";
    } catch (e) {
      this.addError(e);
      return "Unknown Distance Away";
    }
  }

  List<TaskModel> _sortTasks(List<TaskModel> list) {
    List<TaskModel> withoutDueDates = [];
    List<TaskModel> completed = [];

    list.forEach(
      (task) {
        if (task.isDone) {
          completed.add(task);
        }

        if (task.dueDate == null) {
          withoutDueDates.add(task);
        }
      },
    );

    list.removeWhere((e) => withoutDueDates.contains(e));
    list.removeWhere((e) => completed.contains(e));

    list.sort((a, b) => (a.dueDate!.compareTo(b.dueDate!)));

    list.addAll([...withoutDueDates, ...completed]);

    return list;
  }

  void deleteTask(TaskModel task) {
    return _tasksBloc.add(PersonalTaskDeleted(task));
  }

  Stream<List<TaskModel>> getTasksStream() {
    return _tasksBloc.personalTaskDataStream.map(_sortTasks);
  }

  Color? setTaskTypeColor(String type) {
    switch (type) {
      case 'Personal':
        return CupertinoColors.activeBlue;
      case 'School':
        return CupertinoColors.activeOrange;
      case 'Work':
        return CupertinoColors.activeGreen;
      default:
        return null;
    }
  }

  void toggleTaskDone(TaskModel task, bool value) {
    return _tasksBloc.add(
      PersonalTaskUpdated(task.copyWith(isDone: value), silentUpdate: true),
    );
  }
}
