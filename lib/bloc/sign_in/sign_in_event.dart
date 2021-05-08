part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends SignInEvent {
  SignInRequested({required this.email, required this.password});

  final String email, password;

  @override
  List<Object> get props => [email, password];
}
