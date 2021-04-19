part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

// # States
class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  SignInSuccess({@required this.user});
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class SignInFailure extends SignInState {
  SignInFailure({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
