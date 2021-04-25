part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class EventAdditionStarted extends EventsEvent {}

class NewPersonalEventAdded extends EventsEvent {
  const NewPersonalEventAdded({
    @required this.title,
    @required this.description,
    @required this.startDate,
    @required this.endDate,
  });

  final String title, description;
  final DateTime startDate, endDate;

  @override
  List<Object> get props => [title, description, startDate, endDate];
}
