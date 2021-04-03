part of 'loading_bloc.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

// # Loading Started Event
class LoadingStarted extends LoadingEvent {}
