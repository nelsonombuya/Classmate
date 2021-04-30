part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState({
    required this.selectedStartingDate,
    required this.selectedEndingDate,
    required this.isAllDayEvent,
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
    required this.selectedStartingDate,
    required this.selectedEndingDate,
    required this.isAllDayEvent,
  }) : super(
          selectedStartingDate: selectedStartingDate,
          selectedEndingDate: selectedEndingDate,
          isAllDayEvent: isAllDayEvent,
        );

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

class EventAddedSuccessfully extends EventState {
  const EventAddedSuccessfully({
    required this.selectedStartingDate,
    required this.selectedEndingDate,
    required this.isAllDayEvent,
  }) : super(
          selectedStartingDate: selectedStartingDate,
          selectedEndingDate: selectedEndingDate,
          isAllDayEvent: isAllDayEvent,
        );
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

class ErrorAddingEvent extends EventState {
  const ErrorAddingEvent(
    this.errorMessage, {
    required this.selectedStartingDate,
    required this.selectedEndingDate,
    required this.isAllDayEvent,
  }) : super(
          selectedStartingDate: selectedStartingDate,
          selectedEndingDate: selectedEndingDate,
          isAllDayEvent: isAllDayEvent,
        );

  final String errorMessage;
  final DateTime selectedStartingDate;
  final DateTime selectedEndingDate;
  final bool isAllDayEvent;

  @override
  List<Object> get props => [
        errorMessage,
        selectedStartingDate,
        selectedEndingDate,
        isAllDayEvent,
      ];
}

class EventValidation extends EventState {
  const EventValidation({
    required this.selectedStartingDate,
    required this.selectedEndingDate,
    required this.isAllDayEvent,
  }) : super(
          selectedStartingDate: selectedStartingDate,
          selectedEndingDate: selectedEndingDate,
          isAllDayEvent: isAllDayEvent,
        );
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
