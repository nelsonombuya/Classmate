part of 'loading_bloc.dart';

// * Abstract Class
abstract class LoadingState extends Equatable {
  const LoadingState();

  // * Props to be checked during Equations
  @override
  List<Object> get props => [];
}

// # Loading In Progress State
class LoadingInProgress extends LoadingState {}

// # Loading Complete State
class LoadingComplete extends LoadingState {
  const LoadingComplete({this.firstPage}) : assert(firstPage != null);
  final String firstPage;

  @override
  List<Object> get props => [firstPage];
}
