part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class EventAddedSuccessfully extends EventsState {}

class ErrorAddingEvent extends EventsState {
  const ErrorAddingEvent(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class EventValidation extends EventsState {}
