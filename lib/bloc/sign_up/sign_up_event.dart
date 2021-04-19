part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// # Events
class SignUpStarted extends SignUpEvent {
  SignUpStarted({@required this.email, @required this.password});
  final String email, password;
}
