part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  RegistrationSuccess({@required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class RegistrationFailure extends RegistrationState {
  RegistrationFailure({this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
