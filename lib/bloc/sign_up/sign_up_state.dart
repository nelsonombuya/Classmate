part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpValidation extends SignUpState {}

class SignUpSuccess extends SignUpState {
  SignUpSuccess(this.user);
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class SignUpFailure extends SignUpState {
  SignUpFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
