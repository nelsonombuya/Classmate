import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late final TaskRepository _taskRepository;
  late final UserRepository _userRepository;
  late final NotificationBloc _notificationBloc;
  late final Stream<List<TaskModel>> taskDataStream;

  TaskBloc(BuildContext context) : super(TaskInitial()) {
    _userRepository = UserRepository();
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);

    if (_userRepository.getCurrentUser() == null)
      throw Exception("User not signed in ❗");

    _taskRepository = TaskRepository(_userRepository.getCurrentUser()!);
    taskDataStream = _taskRepository.taskDataStream;
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is NewPersonalTaskAdded) {
      yield* _mapNewPersonalTaskAddedToState(event);
    } else if (event is UpdateTaskRequested) {
      yield* _mapUpdateTaskRequestedToState(event);
    } else if (event is DeleteTaskRequested) {
      yield* _mapDeleteTaskRequestedToState(event);
    }
  }

  Stream<TaskState> _mapNewPersonalTaskAddedToState(
      NewPersonalTaskAdded event) async* {
    try {
      _notificationBloc.add(
        AlertRequested(
          "Adding Task",
          notificationType: NotificationType.Loading,
        ),
      );

      Map<String, dynamic> taskData = _parseTaskToMap(event);

      await _taskRepository.createTask(taskData);

      _notificationBloc.add(
        AlertRequested(
          "Task Added Successfully",
          notificationType: NotificationType.Success,
        ),
      );

      yield TaskAddedSuccessfully(title: event.title, isDone: event.isDone);
    } catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Adding Task",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Adding Task",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
      rethrow;
    }
  }

  Stream<TaskState> _mapUpdateTaskRequestedToState(
      UpdateTaskRequested event) async* {
    try {
      Map<String, dynamic> taskData = _parseTaskToMap(event.task);

      _taskRepository.updateTask(event.task, taskData);

      yield TaskUpdatedSuccessfully(event.task);
    } on Exception catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Updating Task",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Updating Task",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
      rethrow;
    }
  }

  Stream<TaskState> _mapDeleteTaskRequestedToState(
      DeleteTaskRequested event) async* {
    try {
      _taskRepository.deleteTask(event.task);
      _notificationBloc.add(
        AlertRequested(
          "Task Deleted",
          notificationType: NotificationType.Success,
        ),
      );
      yield TaskDeletedSuccessfully(event.task);
    } on Exception catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Deleting Task",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Deleting Task",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
      rethrow;
    }
  }

  Map<String, dynamic> _parseTaskToMap(event) {
    return {
      "title": event.title,
      "is_done": event.isDone,
    };
  }
}
