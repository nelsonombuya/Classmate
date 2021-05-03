part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  final List<Stream<DocumentSnapshot>> sessionStreamsList;

  const SessionState(this.sessionStreamsList);

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {
  final List<Stream<DocumentSnapshot>> sessionStreamsList;

  const SessionInitial(this.sessionStreamsList) : super(sessionStreamsList);

  @override
  List<Object> get props => [sessionStreamsList];
}


class SessionStreamListChanged extends SessionState {
  final List<Stream<DocumentSnapshot>> sessionStreamsList;

  const SessionStreamListChanged(this.sessionStreamsList) : super(sessionStreamsList);

  @override
  List<Object> get props => [sessionStreamsList];
}
