part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
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
