import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../notification/notification_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late final TaskRepository _taskRepository;
  late final UserRepository _UserRepository;
  late final NotificationBloc _notificationBloc;
  late final Stream<List<TaskModel>> personalTaskDataStream;

  TaskBloc(BuildContext context) : super(TaskInitial()) {
    _UserRepository = UserRepository();
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);

    if (_UserRepository.getCurrentUser() == null) {
      throw Exception("User not signed in ❗");
    }

    _taskRepository = TaskRepository(_UserRepository.getCurrentUser()!);
    personalTaskDataStream = _taskRepository.personalTaskDataStream;
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is PersonalTaskCreated) {
      yield* _mapPersonalTaskCreatedToState(event);
    } else if (event is PersonalTaskUpdated) {
      yield* _mapPersonalTaskUpdatedToState(event);
    } else if (event is PersonalTaskDeleted) {
      yield* _mapPersonalTaskDeletedToState(event);
    }
  }

  Stream<TaskState> _mapPersonalTaskCreatedToState(
      PersonalTaskCreated event) async* {
    try {
      _notificationBloc.add(
        AlertRequested(
          "Adding Task",
          notificationType: NotificationType.Loading,
        ),
      );

      TaskModel newTask = TaskModel(title: event.title, isDone: event.isDone);
      await _taskRepository.createTask(newTask.toMap());

      yield TaskAddedSuccessfully(title: event.title, isDone: event.isDone);
      _notificationBloc.add(
        AlertRequested(
          "Task Added Successfully",
          notificationType: NotificationType.Success,
        ),
      );
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
    }
  }

  Stream<TaskState> _mapPersonalTaskUpdatedToState(
      PersonalTaskUpdated event) async* {
    try {
      _taskRepository.updateTask(event.task);
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
    }
  }

  Stream<TaskState> _mapPersonalTaskDeletedToState(
      PersonalTaskDeleted event) async* {
    try {
      _taskRepository.deleteTask(event.task);
      yield TaskDeletedSuccessfully(event.task);
      _notificationBloc.add(
        AlertRequested(
          "Task Deleted",
          notificationType: NotificationType.Success,
        ),
      );
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
}
