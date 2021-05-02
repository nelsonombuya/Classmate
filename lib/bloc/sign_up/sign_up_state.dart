part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpValidation extends SignUpState {}

class SignUpSuccess extends SignUpState {
  SignUpSuccess(this.user);
  final AuthModel user;

  @override
  List<Object> get props => [user];
}
