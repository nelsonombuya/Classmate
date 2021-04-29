part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInStarted extends SignInEvent {
  final String email, password;

  SignInStarted({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class SignInRequested extends SignInEvent {}

class SignInValidationFailed extends SignInEvent {}
