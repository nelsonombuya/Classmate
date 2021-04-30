import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/event_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../notification/notification_bloc.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final NotificationBloc _notificationBloc;
  late final EventRepository _eventRepository;
  final UserRepository _userRepository = UserRepository();

  bool _isAllDayEvent = false;
  DateTime _selectedStartingDate = DateTime.now();
  DateTime _selectedEndingDate = DateTime.now().add(Duration(minutes: 30));

  EventBloc(BuildContext context)
      : _notificationBloc = BlocProvider.of<NotificationBloc>(context),
        super(EventInitial()) {
    if (_userRepository.getCurrentUser() == null) {
      throw Exception("User not signed in ❗");
    }
    _eventRepository = EventRepository(_userRepository.getCurrentUser()!);
  }

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is StartingDateChanged) {
      yield* _mapNewStartingDateToState(event);
    } else if (event is EndingDateChanged) {
      yield* _mapNewEndingDateToState(event);
    } else if (event is AllDayEventSet) {
      yield* _mapAllDayEventToState(event);
    } else if (event is EventAdditionRequested) {
      yield* _mapEventAdditionRequestedToState(event);
    } else if (event is NewPersonalEventAdded) {
      yield* _mapNewPersonalEventAddedToState(event);
    }
  }

  Stream<EventState> _mapNewStartingDateToState(
      StartingDateChanged event) async* {
    _selectedStartingDate = event.date;

    if (_selectedEndingDate.isBefore(event.date)) {
      _selectedEndingDate = event.date.add(Duration(minutes: 30));
    }

    yield EventDateChanged(
      selectedStartingDate: _selectedStartingDate,
      selectedEndingDate: _selectedEndingDate,
      isAllDayEvent: _isAllDayEvent,
    );
  }

  Stream<EventState> _mapNewEndingDateToState(EndingDateChanged event) async* {
    _selectedEndingDate = event.date;

    yield EventDateChanged(
      selectedStartingDate: _selectedStartingDate,
      selectedEndingDate: _selectedEndingDate,
      isAllDayEvent: _isAllDayEvent,
    );
  }

  Stream<EventState> _mapAllDayEventToState(AllDayEventSet event) async* {
    _isAllDayEvent = event.isAllDayEvent;

    if (_isAllDayEvent) {
      _selectedStartingDate = DateTime(
        _selectedStartingDate.year,
        _selectedStartingDate.month,
        _selectedStartingDate.day,
      );

      _selectedEndingDate = _selectedStartingDate.add(Duration(hours: 24));
    }

    yield EventDateChanged(
      selectedStartingDate: _selectedStartingDate,
      selectedEndingDate: _selectedEndingDate,
      isAllDayEvent: _isAllDayEvent,
    );
  }

  Stream<EventState> _mapEventAdditionRequestedToState(
      EventAdditionRequested event) async* {
    yield EventValidation(
      selectedStartingDate: _selectedStartingDate,
      selectedEndingDate: _selectedStartingDate,
      isAllDayEvent: _isAllDayEvent,
    );
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
        selectedStartingDate: _selectedStartingDate,
        selectedEndingDate: _selectedEndingDate,
        isAllDayEvent: _isAllDayEvent,
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
      yield ErrorAddingEvent(
        e.toString(),
        selectedStartingDate: _selectedStartingDate,
        selectedEndingDate: _selectedEndingDate,
        isAllDayEvent: _isAllDayEvent,
      );
    }
  }

  Map<String, dynamic> _parseEventToMap(event) {
    return {
      "title": event.title,
      "description": event.description,
      "start_date": event.startDate,
      "end_date": event.endDate,
    };
  }
}
