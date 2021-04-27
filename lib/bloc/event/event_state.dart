part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState({
    @required this.selectedStartingDate,
    @required this.selectedEndingDate,
    @required this.isAllDayEvent,
  });

  final DateTime selectedStartingDate;
  final DateTime selectedEndingDate;

  final bool isAllDayEvent;

  @override
  List<Object> get props => [
        selectedStartingDate,
        selectedEndingDate,
        isAllDayEvent,
      ];
}

class EventInitial extends EventState {
  EventInitial()
      : super(
          selectedStartingDate: DateTime.now(),
          selectedEndingDate: DateTime.now().add(Duration(minutes: 30)),
          isAllDayEvent: false,
        );

  @override
  List<Object> get props => [
        selectedStartingDate,
        selectedEndingDate,
        isAllDayEvent,
      ];
}

class EventDateChanged extends EventState {
  const EventDateChanged({
    @required this.selectedStartingDate,
    @required this.selectedEndingDate,
    @required this.isAllDayEvent,
  });

  final DateTime selectedStartingDate;
  final DateTime selectedEndingDate;
  final bool isAllDayEvent;

  @override
  List<Object> get props => [
        selectedStartingDate,
        selectedEndingDate,
        isAllDayEvent,
      ];
}

class EventAddedSuccessfully extends EventState {}

class ErrorAddingEvent extends EventState {
  const ErrorAddingEvent(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
