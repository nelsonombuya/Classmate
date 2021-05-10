import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../cubit/notification/notification_cubit.dart';
import '../../data/models/event_model.dart';
import '../../data/repositories/event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({
    required EventRepository eventRepository,
    required NotificationCubit notificationCubit,
  })   : _eventRepository = eventRepository,
        _notificationCubit = notificationCubit,
        personalEventDataStream = eventRepository.personalEventDataStream,
        super(EventsState.initial());

  final EventRepository _eventRepository;
  final NotificationCubit _notificationCubit;
  late final Stream<List<EventModel>> personalEventDataStream;

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is PersonalEventCreated) {
      yield* _mapPersonalEventCreatedToState(event);
    } else if (event is PersonalEventUpdated) {
      yield* _mapPersonalEventUpdatedToState(event);
    } else if (event is PersonalEventDeleted) {
      yield* _mapPersonalEventDeletedToState(event);
    }
  }

  Stream<EventsState> _mapPersonalEventCreatedToState(
      PersonalEventCreated event) async* {
    try {
      _showCreatingEventNotification();

      EventModel newEvent = EventModel(
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        isAllDayEvent: event.isAllDayEvent,
      );

      await _eventRepository.createPersonalEvent(newEvent);
      _showEventCreatedSuccessfullyNotification();
      yield EventsState.created(newEvent);
    } catch (e) {
      _showErrorCreatingEventNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<EventsState> _mapPersonalEventUpdatedToState(
      PersonalEventUpdated event) async* {
    try {
      _showUpdatingEventNotification();
      await _eventRepository.updatePersonalEvent(event.event);
      _showEventUpdatedSuccessfullyNotification();
      yield EventsState.updated(event.event);
    } catch (e) {
      _showErrorUpdatingEventNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<EventsState> _mapPersonalEventDeletedToState(
      PersonalEventDeleted event) async* {
    try {
      _showDeletingEventNotification();
      await _eventRepository.deletePersonalEvent(event.event);
      _showEventDeletedSuccessfullyNotification();
      yield EventsState.deleted(event.event);
    } on Exception catch (e) {
      _showErrorDeletingEventNotification(e.toString());
      this.addError(e);
    }
  }

  // ## Notifications
  void _showCreatingEventNotification() {
    return _notificationCubit.showAlert(
      "Creating Event",
      type: NotificationType.Loading,
    );
  }

  void _showUpdatingEventNotification() {
    return _notificationCubit.showAlert(
      "Updating Event",
      type: NotificationType.Loading,
    );
  }

  void _showDeletingEventNotification() {
    return _notificationCubit.showAlert(
      "Deleting Event",
      type: NotificationType.Loading,
    );
  }

  void _showEventCreatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Event Created",
      type: NotificationType.Success,
    );
  }

  void _showEventUpdatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Event Updated",
      type: NotificationType.Success,
    );
  }

  void _showEventDeletedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Event Updated",
      type: NotificationType.Success,
    );
  }

  void _showErrorCreatingEventNotification(String message) {
    _notificationCubit.showAlert(
      "Error Creating Event",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Creating Event",
      type: NotificationType.Danger,
    );
  }

  void _showErrorUpdatingEventNotification(String message) {
    _notificationCubit.showAlert(
      "Error Updating Event",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Updating Event",
      type: NotificationType.Danger,
    );
  }

  void _showErrorDeletingEventNotification(String message) {
    _notificationCubit.showAlert(
      "Error Deleting Event",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Deleting Event",
      type: NotificationType.Danger,
    );
  }
}
