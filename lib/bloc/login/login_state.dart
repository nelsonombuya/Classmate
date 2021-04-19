part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({@required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  LoginFailure({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
