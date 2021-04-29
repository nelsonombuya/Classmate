part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends SignUpEvent {}

class SignUpValidationFailed extends SignUpEvent {}

class SignUpStarted extends SignUpEvent {
  const SignUpStarted({
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  final String email, password, firstName, lastName;

  @override
  List<Object> get props => [];
}
