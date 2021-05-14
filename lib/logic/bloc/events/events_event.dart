part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class PersonalEventCreated extends EventsEvent {
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
  List<Object> get props => [
        "Title : $title",
        "Description: $description",
        "From: $startDate",
        "To: $endDate",
        "All Day Event: $isAllDayEvent",
      ];
}

abstract class ExistingEvent extends EventsEvent {
  const ExistingEvent(this.event);

  final EventModel event;

  @override
  List<Object> get props => [event];
}

class PersonalEventUpdated extends ExistingEvent {
  const PersonalEventUpdated(this.event) : super(event);

  final EventModel event;

  @override
  List<Object> get props => [event];
}

class PersonalEventDeleted extends ExistingEvent {
  const PersonalEventDeleted(this.event, {this.popCurrentPage = true})
      : super(event);

  final EventModel event;
  final bool popCurrentPage;

  @override
  List<Object> get props => [event];
}
