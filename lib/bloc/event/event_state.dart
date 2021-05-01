part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventAddedSuccessfully extends EventState {
  const EventAddedSuccessfully({
    required this.selectedStartingDate,
    required this.selectedEndingDate,
  });

  final DateTime selectedStartingDate;
  final DateTime selectedEndingDate;

  @override
  List<Object> get props => [
        "Starts: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedStartingDate)}",
        "Ends: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedEndingDate)}",
      ];
}

class ErrorAddingEvent extends EventState {
  const ErrorAddingEvent(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
