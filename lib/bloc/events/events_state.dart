part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class EventCreatedSuccessfully extends EventsState {
  const EventCreatedSuccessfully(this.event);

  final EventModel event;

  @override
  List<Object> get props => [event];
}

class EventUpdatedSuccessfully extends EventsState {
  const EventUpdatedSuccessfully(this.event);

  final EventModel event;

  @override
  List<Object> get props => [event];
}

class EventDeletedSuccessfully extends EventsState {
  const EventDeletedSuccessfully(this.event);

  final EventModel event;

  @override
  List<Object> get props => [event];
}
