part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpStarted extends SignUpEvent {
  const SignUpStarted({
    @required this.password,
    @required this.email,
    this.firstName,
    this.lastName,
  });

  final String email, password, firstName, lastName;
}

class SignUpRequested extends SignUpEvent {}

class SignUpValidationFailed extends SignUpEvent {}
