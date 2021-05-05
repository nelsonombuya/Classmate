part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class PersonalEventCreated extends EventEvent {
  const PersonalEventCreated({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDayEvent,
  });

  final String title, description;
  final DateTime startDate, endDate;
  final bool isAllDayEvent;

  @override
  List<Object> get props =>
      [title, description, startDate, endDate, isAllDayEvent];
}

class PersonalEventUpdated extends EventEvent {
  const PersonalEventUpdated({
    required this.docId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDayEvent,
  });

  final String title, description, docId;
  final DateTime startDate, endDate;
  final bool isAllDayEvent;

  @override
  List<Object> get props =>
      [title, description, startDate, endDate, isAllDayEvent];
}

class PersonalEventDeleted extends EventEvent {
  final EventModel event;

  const PersonalEventDeleted(this.event);

  @override
  List<Object> get props => [event];
}
