import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/task_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final NotificationBloc _notificationBloc;
  final UserRepository _userRepository;

  late final Stream taskDataStream;
  late final TaskRepository _taskRepository;

  TaskBloc(BuildContext context)
      : _notificationBloc = BlocProvider.of<NotificationBloc>(context),
        _userRepository = UserRepository(),
        super(TaskInitial()) {
    try {
      if (_userRepository.getCurrentUser() == null) {
        throw Exception("User not signed in ❗");
      }
      _taskRepository = TaskRepository(_userRepository.getCurrentUser()!);
      taskDataStream = _taskRepository.taskDataStream;
    } on Exception catch (e) {
      this.addError(e);
      rethrow;
    }
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is NewPersonalTaskAdded) {
      yield* _mapNewPersonalTaskAddedToState(event);
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

  Map<String, dynamic> _parseTaskToMap(event) {
    return {
      "title": event.title,
      "is_done": event.isDone,
    };
  }
}
