part of 'add_event_cubit.dart';

abstract class AddEventState extends Equatable {
  AddEventState({
    required this.selectedStartingDate,
    required this.selectedEndingDate,
    required this.isAllDayEvent,
  });

  final DateTime selectedStartingDate;
  final DateTime selectedEndingDate;
  final bool isAllDayEvent;

  @override
  List<Object> get props => [
        "Starts: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedStartingDate)}",
        "Ends: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedEndingDate)}",
        "All Day Event : $isAllDayEvent",
      ];
}

class AddEventInitial extends AddEventState {
  AddEventInitial({
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
        "Starts: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedStartingDate)}",
        "Ends: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedEndingDate)}",
        "All Day Event : $isAllDayEvent",
      ];
}

class EventDateChanged extends AddEventState {
  EventDateChanged({
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
        "Starts: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedStartingDate)}",
        "Ends: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedEndingDate)}",
        "All Day Event : $isAllDayEvent",
      ];
}

class EventValidation extends AddEventState {
  EventValidation({
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
        "Starts: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedStartingDate)}",
        "Ends: ${DateFormat('EEEE MMM dd yyyy - kk:mm').format(selectedEndingDate)}",
        "All Day Event : $isAllDayEvent",
      ];
}
