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
  });

  final String title, description;
  final DateTime startDate, endDate;

  @override
  List<Object> get props => [title, description, startDate, endDate];
}

class PersonalEventUpdated extends EventEvent {
  final EventModel event;

  const PersonalEventUpdated(this.event);

  @override
  List<Object> get props => [event];
}

class PersonalEventDeleted extends EventEvent {
  final EventModel event;

  const PersonalEventDeleted(this.event);

  @override
  List<Object> get props => [event];
}
