import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/event_model.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final NotificationBloc _notificationBloc;
  final UserRepository _userRepository = UserRepository();

  late final EventRepository _eventRepository;
  late final Stream<List<EventModel>> eventDataStream;

  EventBloc(BuildContext context)
      : _notificationBloc = BlocProvider.of<NotificationBloc>(context),
        super(EventInitial()) {
    try {
      if (_userRepository.getCurrentUser() == null) {
        throw Exception("User not signed in ❗");
      }
      _eventRepository = EventRepository(_userRepository.getCurrentUser()!);
      eventDataStream = _eventRepository.eventDataStream;
    } on Exception catch (e) {
      this.addError(e);
      rethrow;
    }
  }

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is NewPersonalEventAdded) {
      yield* _mapNewPersonalEventAddedToState(event);
    }
  }

  Stream<EventState> _mapNewPersonalEventAddedToState(
      NewPersonalEventAdded event) async* {
    try {
      _notificationBloc.add(
        AlertRequested(
          "Adding Event",
          notificationType: NotificationType.Loading,
        ),
      );

      Map<String, dynamic> eventData = _parseEventToMap(event);
      await _eventRepository.createEvent(eventData);

      _notificationBloc.add(
        AlertRequested(
          "Event Added Successfully",
          notificationType: NotificationType.Success,
        ),
      );
      yield EventAddedSuccessfully(
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
      rethrow;
    }
  }

  Map<String, dynamic> _parseEventToMap(event) {
    return {
      "title": event.title,
      "description": event.description,
      "start_date": event.startDate.millisecondsSinceEpoch,
      "end_date": event.endDate.millisecondsSinceEpoch,
    };
  }
}
