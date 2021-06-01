import 'package:bloc/bloc.dart';
import 'package:classmate/logic/bloc/events/events_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/event_model.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit({required EventsBloc eventsBloc})
      : _eventsBloc = eventsBloc,
        super(CreateEventState(
          selectedStartingDate: DateTime.now(),
          selectedEndingDate: DateTime.now().add(Duration(minutes: 30)),
          isAllDayEvent: false,
        ));

  final descriptionController = TextEditingController();
  final eventTypes = <String>['Personal', 'Work', 'School'];
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  final EventsBloc _eventsBloc;

  DateTime _adjustSelectedEndingDate(DateTime newDate) {
    if (state.isAllDayEvent) {
      return newDate.add(Duration(hours: 24));
    }

    if (state.selectedEndingDate.isBefore(newDate)) {
      return newDate.add(Duration(minutes: 30));
    }

    return state.selectedEndingDate;
  }

  void _createNewEvent() {
    return _eventsBloc.add(
      PersonalEventCreated(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        startDate: state.selectedStartingDate,
        endDate: state.selectedEndingDate,
        isAllDayEvent: state.isAllDayEvent,
        eventType: state.eventType,
      ),
    );
  }

  void _updateExistingEvent(Event event) {
    return _eventsBloc.add(
      PersonalEventUpdated(
        event.copyWith(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          startDate: state.selectedStartingDate,
          endDate: state.selectedEndingDate,
          isAllDayEvent: state.isAllDayEvent,
          eventType: state.eventType,
        ),
      ),
    );
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
      eventType: state.eventType,
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
      eventType: state.eventType,
    ));
  }

  void changeEventType(String type) {
    return emit(CreateEventState(
      selectedStartingDate: state.selectedStartingDate,
      selectedEndingDate: state.selectedEndingDate,
      isAllDayEvent: state.isAllDayEvent,
      eventType: type,
    ));
  }

  void changeStartingDate(DateTime newDate) {
    emit(CreateEventState(
      selectedStartingDate: newDate,
      selectedEndingDate: _adjustSelectedEndingDate(newDate),
      isAllDayEvent: state.isAllDayEvent,
      eventType: state.eventType,
    ));
  }

  void initializeEventDetails(Event event) {
    titleController.text = event.title;

    if (event.description != null) {
      descriptionController.text = event.description!;
    }

    emit(CreateEventState(
      selectedStartingDate: event.startDate,
      selectedEndingDate: event.endDate,
      isAllDayEvent: event.isAllDayEvent,
      eventType: state.eventType,
    ));
  }

  void saveEvent(Event? event) {
    if (formKey.currentState!.validate()) {
      return event == null ? _createNewEvent() : _updateExistingEvent(event);
    }
  }
}
