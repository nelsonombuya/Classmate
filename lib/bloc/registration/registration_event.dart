part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressedEvent extends RegistrationEvent {
  SignUpButtonPressedEvent({@required this.email, @required this.password});
  final String email, password;

  @override
  List<Object> get props => [];
}
