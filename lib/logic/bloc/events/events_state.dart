part of 'events_bloc.dart';

class EventsState extends Equatable {
  const EventsState.initial({this.event});

  const EventsState.created(this.event);

  const EventsState.updated(this.event);

  const EventsState.deleted(this.event);

  final Event? event;

  @override
  List<Object> get props => [event ?? '-'];
}
