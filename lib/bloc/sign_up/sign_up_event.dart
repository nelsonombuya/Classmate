part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends SignUpEvent {}

class SignUpCredentialsInvalid extends SignUpEvent {}

class SignUpCredentialsValid extends SignUpEvent {
  const SignUpCredentialsValid({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  final String email, password, firstName, lastName;

  @override
  List<Object> get props => [];
}
