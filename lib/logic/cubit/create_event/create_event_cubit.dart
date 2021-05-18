import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../data/models/event_model.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit()
      : super(CreateEventState(
          selectedStartingDate: DateTime.now(),
          selectedEndingDate: DateTime.now().add(Duration(minutes: 30)),
          isAllDayEvent: false,
        ));

  void updateEventDetails(Event event) {
    emit(CreateEventState(
      selectedStartingDate: event.startDate,
      selectedEndingDate: event.endDate,
      isAllDayEvent: event.isAllDayEvent,
    ));
  }

  void changeStartingDate(DateTime newDate) {
    emit(CreateEventState(
      selectedStartingDate: newDate,
      selectedEndingDate: _adjustSelectedEndingDate(newDate),
      isAllDayEvent: state.isAllDayEvent,
    ));
  }

  void changeEndingDate(DateTime newDate) {
    if (newDate.isBefore(state.selectedStartingDate))
      throw Exception(
        "The event's ending date can't come before it's starting date ⛔",
      );

    emit(CreateEventState(
      selectedStartingDate: state.selectedStartingDate,
      selectedEndingDate: newDate,
      isAllDayEvent: state.isAllDayEvent,
    ));
  }

  void changeAllDayEventState(bool isAllDayEvent) {
    DateTime selectedStartingDate;
    DateTime selectedEndingDate;

    if (isAllDayEvent) {
      selectedStartingDate = DateTime(
        state.selectedStartingDate.year,
        state.selectedStartingDate.month,
        state.selectedStartingDate.day,
      );

      selectedEndingDate = selectedStartingDate.add(Duration(hours: 24));
    } else {
      selectedStartingDate = state.selectedStartingDate;
      selectedEndingDate = state.selectedEndingDate;
    }

    emit(CreateEventState(
      selectedStartingDate: selectedStartingDate,
      selectedEndingDate: selectedEndingDate,
      isAllDayEvent: isAllDayEvent,
    ));
  }

  DateTime _adjustSelectedEndingDate(DateTime newDate) {
    if (state.isAllDayEvent) return newDate.add(Duration(hours: 24));

    if (state.selectedEndingDate.isBefore(newDate))
      return newDate.add(Duration(minutes: 30));

    return state.selectedEndingDate;
  }
}
