part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckStarted extends AuthEvent {}

class AuthRemoved extends AuthEvent {}

class AuthChanged extends AuthEvent {
  final AuthModel? user;

  const AuthChanged({this.user});

  @override
  List<Object> get props => [user == null ? 'No User Signed In' : user!.uid];
}

class AuthErrorOccurred extends AuthEvent {
  const AuthErrorOccurred(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
