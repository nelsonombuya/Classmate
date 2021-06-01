part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

abstract class ExistingEvent extends EventsEvent {
  const ExistingEvent(this.event);

  final Event event;

  @override
  List<Object> get props => [event];
}

class PersonalEventCreated extends EventsEvent {
  const PersonalEventCreated({
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.isAllDayEvent,
    required this.eventType,
  });

  final String title;
  final bool isAllDayEvent;
  final String? description;
  final DateTime startDate, endDate;
  final String eventType;

  @override
  List<Object> get props => [
        "Title : $title",
        "Description: ${description ?? 'No Description'}",
        "From: $startDate",
        "To: $endDate",
        "All Day Event: $isAllDayEvent",
      ];
}

class PersonalEventUpdated extends ExistingEvent {
  const PersonalEventUpdated(this.event) : super(event);

  final Event event;

  @override
  List<Object> get props => [event];
}

class PersonalEventDeleted extends ExistingEvent {
  const PersonalEventDeleted(this.event, {this.popCurrentPage = true})
      : super(event);

  final Event event;
  final bool popCurrentPage;

  @override
  List<Object> get props => [event];
}
