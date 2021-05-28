part of 'create_event_cubit.dart';

class CreateEventState extends Equatable {
  CreateEventState({
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
