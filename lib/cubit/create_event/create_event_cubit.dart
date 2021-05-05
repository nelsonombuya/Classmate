import 'package:bloc/bloc.dart';
import 'package:classmate/data/models/event_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit()
      : super(CreateEventInitial(
          selectedStartingDate: DateTime.now(),
          selectedEndingDate: DateTime.now().add(Duration(minutes: 30)),
          isAllDayEvent: false,
        ));

  void editEventDetails(EventModel event) {
    emit(EventDateChanged(
      selectedStartingDate: event.startDate,
      selectedEndingDate: event.endDate,
      isAllDayEvent: event.isAllDayEvent,
    ));
  }

  void changeStartingDate(DateTime newDate) {
    DateTime selectedStartingDate = newDate;
    DateTime selectedEndingDate;

    if (state.isAllDayEvent) {
      selectedEndingDate = newDate.add(Duration(hours: 24));
    } else if (state.selectedEndingDate.isBefore(newDate)) {
      selectedEndingDate = newDate.add(Duration(minutes: 30));
    } else {
      selectedEndingDate = state.selectedEndingDate;
    }

    emit(EventDateChanged(
      selectedStartingDate: selectedStartingDate,
      selectedEndingDate: selectedEndingDate,
      isAllDayEvent: state.isAllDayEvent,
    ));
  }

  void changeEndingDate(DateTime newDate) {
    DateTime selectedEndingDate = newDate;

    if (selectedEndingDate.isBefore(state.selectedStartingDate)) {
      throw Exception(
        "The event's ending date can't come before it's starting date ⛔",
      );
    }

    emit(EventDateChanged(
      selectedStartingDate: state.selectedStartingDate,
      selectedEndingDate: selectedEndingDate,
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

    emit(EventDateChanged(
      selectedStartingDate: selectedStartingDate,
      selectedEndingDate: selectedEndingDate,
      isAllDayEvent: isAllDayEvent,
    ));
  }

  void validateNewEvent() {
    emit(EventValidation(
      selectedStartingDate: state.selectedStartingDate,
      selectedEndingDate: state.selectedEndingDate,
      isAllDayEvent: state.isAllDayEvent,
    ));
  }
}
