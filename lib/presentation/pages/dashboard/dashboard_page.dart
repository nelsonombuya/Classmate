import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/device_query.dart';
import '../../../cubit/session/session_cubit.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../common_widgets/no_data_found.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit(),
      child: DashboardPageView(),
    );
  }
}

class DashboardPageView extends StatefulWidget {
  @override
  _DashboardPageViewState createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  _formatFirebaseTimestamp(String format, Timestamp timestamp) {
    return DateFormat(format)
        .format(DateTime.parse(timestamp.toDate().toString()));
  }

  @override
  Widget build(BuildContext context) {
    DeviceQuery _deviceQuery = DeviceQuery.of(context);
    ScrollController _listViewController = ScrollController();
    SessionCubit _sessionCubit = BlocProvider.of<SessionCubit>(context);
    AuthModel _currentUser = AuthRepository().getCurrentUser()!;
    String _currentUserUid = _currentUser.uid;

    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        if (state.lessonStreamsList.isEmpty) {
          return NoDataFound(message: "Register your course and units");
        }

        return ListView.builder(
          shrinkWrap: true,
          controller: _listViewController,
          itemCount: state.lessonStreamsList.length,
          itemBuilder: (context, unitIndex) {
            return StreamBuilder<DocumentSnapshot>(
              stream: state.lessonStreamsList[unitIndex],
              builder: (context, sessionSnapshot) {
                if (sessionSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (sessionSnapshot.hasData && sessionSnapshot.data != null) {
                  var sessionData = sessionSnapshot.data!.data();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ListTile(
                            enableFeedback: true,
                            leading: Icon(
                              Icons.school_rounded,
                              color: CupertinoColors.activeOrange,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            onTap:
                                () {}, // TODO Changing Class details for Class Reps
                            tileColor:
                                _deviceQuery.brightness == Brightness.light
                                    ? CupertinoColors.systemGroupedBackground
                                    : CupertinoColors.darkBackgroundGray,
                            title: Text(
                              "${sessionData!['name']}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            subtitle: Text(
                              "On ${_formatFirebaseTimestamp('EEEE', sessionData['class_start_time'])}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "${_formatFirebaseTimestamp('hh:mm aa', sessionData['class_start_time'])}"),
                                Text("TO"),
                                Text(
                                    "${_formatFirebaseTimestamp('hh:mm aa', sessionData['class_end_time'])}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: state.assignmentStreamsList[unitIndex],
                          builder: (context, assignmentsSnapshot) {
                            if (assignmentsSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator.adaptive();
                            }

                            if (assignmentsSnapshot.hasData) {
                              var numberOfAssignments =
                                  assignmentsSnapshot.data!.docs.length;

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: numberOfAssignments,
                                controller: ScrollController(),
                                itemBuilder: (context, index) {
                                  var assignmentId =
                                      assignmentsSnapshot.data!.docs[index].id;
                                  var assignment = assignmentsSnapshot
                                      .data!.docs[index]
                                      .data();
                                  var title = assignment['title'];
                                  var isDone =
                                      assignment['users']?[_currentUserUid];
                                  if (isDone == null) isDone = false;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CheckboxListTile(
                                        activeColor: CupertinoColors.activeBlue,
                                        value: isDone,
                                        onChanged: (value) {
                                          if (value == null) {
                                            throw Exception(
                                                "The checked value shouldn't be null ❗");
                                          }
                                          _sessionCubit.updateAssignmentDetails(
                                            assignmentId: assignmentId,
                                            session:
                                                state.sessionList[unitIndex],
                                            user: _currentUser,
                                            value: value,
                                          );
                                        },
                                        tileColor: _deviceQuery.brightness ==
                                                Brightness.light
                                            ? CupertinoColors
                                                .systemGroupedBackground
                                            : CupertinoColors
                                                .darkBackgroundGray,
                                        title: Text(
                                          title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                decoration: isDone
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                color: isDone
                                                    ? Theme.of(context)
                                                        .disabledColor
                                                    : null,
                                              ),
                                        ),
                                        subtitle: Text((assignment[
                                                    'due_date'] !=
                                                null)
                                            ? "${_formatFirebaseTimestamp('EEE dd hh:mm aa', assignment['due_date'])}"
                                            : "No Due Date Set"),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return NoDataFound(message: "No Assignments Found");
                          })
                    ],
                  );
                }
                return NoDataFound(message: "Something went wrong");
              },
            );
          },
        );
      },
    );
  }
}
