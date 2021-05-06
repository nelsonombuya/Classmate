part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  final List<Stream<DocumentSnapshot>> lessonStreamsList;
  final List<Stream<QuerySnapshot>> assignmentStreamsList;
  final List<SessionRepository> sessionList;

  const SessionState(
    this.lessonStreamsList,
    this.assignmentStreamsList,
    this.sessionList,
  );

  @override
  List<Object> get props => [
        lessonStreamsList,
        assignmentStreamsList,
        sessionList,
      ];
}

class SessionInitial extends SessionState {
  final List<Stream<DocumentSnapshot>> lessonStreamsList;
  final List<Stream<QuerySnapshot>> assignmentStreamsList;
  final List<SessionRepository> sessionList;

  const SessionInitial(
    this.lessonStreamsList,
    this.assignmentStreamsList,
    this.sessionList,
  ) : super(
          lessonStreamsList,
          assignmentStreamsList,
          sessionList,
        );

  @override
  List<Object> get props => [
        lessonStreamsList,
        assignmentStreamsList,
        sessionList,
      ];
}

class SessionStreamListChanged extends SessionState {
  final List<Stream<DocumentSnapshot>> lessonStreamsList;
  final List<Stream<QuerySnapshot>> assignmentStreamsList;
  final List<SessionRepository> sessionList;

  const SessionStreamListChanged(
    this.lessonStreamsList,
    this.assignmentStreamsList,
    this.sessionList,
  ) : super(
          lessonStreamsList,
          assignmentStreamsList,
          sessionList,
        );

  @override
  List<Object> get props => [
        lessonStreamsList,
        assignmentStreamsList,
        sessionList,
      ];
}
