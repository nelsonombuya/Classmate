import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../constants/enums.dart';
import '../../constants/error_handler.dart';
import '../../data/repositories/events_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../notifications/notifications_bloc.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  NotificationsBloc _notificationsBloc = NotificationsBloc();

  UserRepository _userRepository = UserRepository();
  EventsRepository _eventsRepository;

  EventsBloc() : super(EventsInitial()) {
    _eventsRepository = EventsRepository(_userRepository.currentUser());
  }

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is EventAdditionStarted) yield EventValidation();

    if (event is NewPersonalEventAdded) {
      try {
        await _addNewEvent(event);
        yield EventAddedSuccessfully();
      } catch (e) {
        // ! Show snackbar with error message
        _notificationsBloc.add(
          SnackBarRequested(
            ErrorHandler(e).message,
            title: "Error Adding Event",
            notificationType: NotificationType.Danger,
          ),
        );

        // ! Return error state
        yield ErrorAddingEvent(ErrorHandler(e).message);
      }
    }
  }

  Map<String, dynamic> _parseEventToMap(event) {
    // ### Setting the data... responsibly
    return {
      "title": event.title,
      "description": event.description,
      "start_date": event.startDate,
      "end_date": event.endDate,
    };
  }

  // ## For Adding New Events
  Future<void> _addNewEvent(event) async {
    Map<String, dynamic> eventData = _parseEventToMap(event);

    // Adding the new event to the Database
    await _eventsRepository.createEventData(eventData);
  }
}
