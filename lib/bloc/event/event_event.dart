part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class StartingDateChanged extends EventEvent {
  const StartingDateChanged(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class EndingDateChanged extends EventEvent {
  const EndingDateChanged(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class AllDayEventSet extends EventEvent {
  const AllDayEventSet(this.isAllDayEvent);

  final bool isAllDayEvent;

  @override
  List<Object> get props => [isAllDayEvent];
}

class NewPersonalEventAdded extends EventEvent {
  const NewPersonalEventAdded({
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

class EventAdditionRequested extends EventEvent {}
