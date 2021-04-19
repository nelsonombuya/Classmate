part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

// # States
class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  SignUpSuccess({@required this.user});
  final UserModel user;

  @override
  List<Object> get props => [user];
}

class SignUpFailure extends SignUpState {
  SignUpFailure({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
