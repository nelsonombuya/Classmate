part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckStarted extends AuthEvent {}

class AuthRemoved extends AuthEvent {}

class AuthChanged extends AuthEvent {
  final UserModel? user;

  const AuthChanged({this.user});

  @override
  List<Object> get props => [user ?? 'No User'];
}

class AuthErrorOccurred extends AuthEvent {
  const AuthErrorOccurred(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
