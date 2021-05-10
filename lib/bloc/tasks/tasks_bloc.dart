import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../cubit/notification/notification_cubit.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({
    required TaskRepository taskRepository,
    required NotificationCubit notificationCubit,
  })   : _taskRepository = taskRepository,
        _notificationCubit = notificationCubit,
        personalTaskDataStream = taskRepository.personalTaskDataStream,
        super(TasksState.initial());

  final TaskRepository _taskRepository;
  final NotificationCubit _notificationCubit;
  late final Stream<List<TaskModel>> personalTaskDataStream;

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is PersonalTaskCreated) {
      yield* _mapPersonalTaskCreatedToState(event);
    } else if (event is PersonalTaskUpdated) {
      yield* _mapPersonalTaskUpdatedToState(event);
    } else if (event is PersonalTaskDeleted) {
      yield* _mapPersonalTaskDeletedToState(event);
    }
  }

  Stream<TasksState> _mapPersonalTaskCreatedToState(
      PersonalTaskCreated event) async* {
    try {
      _showCreatingTaskNotification();
      TaskModel newTask = TaskModel(title: event.title, isDone: false);
      await _taskRepository.createPersonalTask(newTask);
      _showTaskCreatedSuccessfullyNotification();
      yield TasksState.created(newTask);
    } catch (e) {
      _showErrorCreatingTaskNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<TasksState> _mapPersonalTaskUpdatedToState(
      PersonalTaskUpdated event) async* {
    try {
      _showUpdatingTaskNotification();
      await _taskRepository.updatePersonalTask(event.task);
      _showTaskUpdatedSuccessfullyNotification();
      yield TasksState.updated(event.task);
    } catch (e) {
      _showErrorUpdatingTaskNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<TasksState> _mapPersonalTaskDeletedToState(
      PersonalTaskDeleted event) async* {
    try {
      _showDeletingTaskNotification();
      await _taskRepository.deletePersonalTask(event.task);
      _showTaskDeletedSuccessfullyNotification();
      yield TasksState.deleted(event.task);
    } on Exception catch (e) {
      _showErrorDeletingTaskNotification(e.toString());
      this.addError(e);
    }
  }

  // ## Notifications
  void _showCreatingTaskNotification() {
    return _notificationCubit.showAlert(
      "Creating Task",
      type: NotificationType.Loading,
    );
  }

  void _showUpdatingTaskNotification() {
    return _notificationCubit.showAlert(
      "Updating Task",
      type: NotificationType.Loading,
    );
  }

  void _showDeletingTaskNotification() {
    return _notificationCubit.showAlert(
      "Deleting Task",
      type: NotificationType.Loading,
    );
  }

  void _showTaskCreatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Task Created",
      type: NotificationType.Success,
    );
  }

  void _showTaskUpdatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Task Updated",
      type: NotificationType.Success,
    );
  }

  void _showTaskDeletedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Task Updated",
      type: NotificationType.Success,
    );
  }

  void _showErrorCreatingTaskNotification(String message) {
    _notificationCubit.showAlert(
      "Error Creating Task",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Creating Event",
      type: NotificationType.Danger,
    );
  }

  void _showErrorUpdatingTaskNotification(String message) {
    _notificationCubit.showAlert(
      "Error Updating Task",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Updating Event",
      type: NotificationType.Danger,
    );
  }

  void _showErrorDeletingTaskNotification(String message) {
    _notificationCubit.showAlert(
      "Error Deleting Task",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Deleting Task",
      type: NotificationType.Danger,
    );
  }
}
