import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/device_query.dart';
import '../../../cubit/session/session_cubit.dart';
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

    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        if (state.sessionStreamsList.isEmpty) {
          return NoDataFound(message: "Register your course and units");
        }

        return ListView.builder(
          shrinkWrap: true,
          controller: _listViewController,
          itemCount: state.sessionStreamsList.length,
          itemBuilder: (context, index) {
            return StreamBuilder<DocumentSnapshot>(
              stream: state.sessionStreamsList[index],
              builder: (context, sessionSnapshot) {
                if (sessionSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }

                if (sessionSnapshot.hasData && sessionSnapshot.data != null) {
                  var sessionData = sessionSnapshot.data!.data();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ListTile(
                        enableFeedback: true,
                        leading: Icon(
                          Icons.school_rounded,
                          color: CupertinoColors.activeOrange,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        onTap:
                            () {}, // TODO Changing Class details for Class Reps
                        tileColor: _deviceQuery.brightness == Brightness.light
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
