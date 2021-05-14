part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  SignInSuccess(this.uid);

  final String uid;

  @override
  List<Object> get props => [uid, DateTime.now()];
}

class SignInFailure extends SignInState {
  SignInFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
