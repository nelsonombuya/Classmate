part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {
  SignUpSuccess(this.uid);

  final String uid;

  @override
  List<Object> get props => [uid, DateTime.now()];
}

class SignUpFailure extends SignUpState {
  SignUpFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
