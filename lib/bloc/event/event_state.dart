part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventCreatedSuccessfully extends EventState {
  final DateTime selectedStartingDate;
  final DateTime selectedEndingDate;

  const EventCreatedSuccessfully({
    required this.selectedStartingDate,
    required this.selectedEndingDate,
  });

  @override
  List<Object> get props => [
        "Starts: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedStartingDate)}",
        "Ends: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedEndingDate)}",
      ];
}

class EventUpdatedSuccessfully extends EventState {
  final EventModel event;

  const EventUpdatedSuccessfully(this.event);

  @override
  List<Object> get props => [event];
}

class EventDeletedSuccessfully extends EventState {
  final EventModel event;

  const EventDeletedSuccessfully(this.event);

  @override
  List<Object> get props => [event];
}
