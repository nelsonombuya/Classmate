import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/event_model.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/event_repository.dart';
import '../notification/notification_bloc.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  late final AuthenticationRepository _AuthenticationRepository;
  late final EventRepository _eventRepository;
  late final NotificationBloc _notificationBloc;
  late final Stream<List<EventModel>> personalEventDataStream;

  EventBloc(BuildContext context) : super(EventInitial()) {
    _AuthenticationRepository = AuthenticationRepository();
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);

    if (_AuthenticationRepository.getCurrentUser() == null) {
      this.addError("User not signed in ❗");
      throw Exception("User not signed in ❗");
    }

    _eventRepository =
        EventRepository(_AuthenticationRepository.getCurrentUser()!);
    personalEventDataStream = _eventRepository.personalEventDataStream;
  }

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is PersonalEventCreated) {
      yield* _mapPersonalEventCreatedToState(event);
    } else if (event is PersonalEventUpdated) {
      yield* _mapPersonalEventUpdatedToState(event);
    } else if (event is PersonalEventDeleted) {
      yield* _mapPersonalEventDeletedToState(event);
    }
  }

  Stream<EventState> _mapPersonalEventCreatedToState(
      PersonalEventCreated event) async* {
    try {
      _notificationBloc.add(
        AlertRequested(
          "Adding Event",
          notificationType: NotificationType.Loading,
        ),
      );

      EventModel newEvent = EventModel(
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        isAllDayEvent: event.isAllDayEvent,
      );

      await _eventRepository.createEvent(newEvent);

      _notificationBloc.add(
        AlertRequested(
          "Event Added Successfully",
          notificationType: NotificationType.Success,
        ),
      );
      yield EventCreatedSuccessfully(
        selectedStartingDate: event.startDate,
        selectedEndingDate: event.endDate,
      );
    } catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Adding Event",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Adding Event",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
    }
  }

  Stream<EventState> _mapPersonalEventUpdatedToState(
      PersonalEventUpdated event) async* {
    try {
      EventModel updatedEvent = EventModel(
        docId: event.docId,
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        isAllDayEvent: event.isAllDayEvent,
      );

      _eventRepository.updateEvent(updatedEvent);
      yield EventUpdatedSuccessfully(updatedEvent);
      _notificationBloc.add(
        AlertRequested(
          "Event Updated",
          notificationType: NotificationType.Success,
        ),
      );
    } catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Updating Event",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Updating Event",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
    }
  }

  Stream<EventState> _mapPersonalEventDeletedToState(
      PersonalEventDeleted event) async* {
    try {
      _eventRepository.deleteEvent(event.event);
      yield EventDeletedSuccessfully(event.event);
      _notificationBloc.add(
        AlertRequested(
          "Event Deleted",
          notificationType: NotificationType.Success,
        ),
      );
    } on Exception catch (e) {
      _notificationBloc.add(
        AlertRequested(
          "Error Deleting Event",
          notificationType: NotificationType.Danger,
        ),
      );
      _notificationBloc.add(
        SnackBarRequested(
          e.toString(),
          title: "Error Deleting Event",
          notificationType: NotificationType.Danger,
        ),
      );
      this.addError(e);
    }
  }
}
