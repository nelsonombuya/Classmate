import 'package:classmate/constants/device_query.dart';
import 'package:classmate/data/models/assignment_model.dart';
import 'package:classmate/data/models/lesson_model.dart';

import 'package:classmate/logic/cubit/school/school_cubit.dart';
import 'package:intl/intl.dart';

import 'package:classmate/presentation/common_widgets/no_data_found.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    return BlocBuilder<SchoolCubit, SchoolState>(
      builder: (context, state) {
        return StreamBuilder<List>(
          stream: context.read<SchoolCubit>().getCombinedStreams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasData && snapshot.data != null) {
              var combinedList = [];
              snapshot.data!.forEach((element) => combinedList.addAll(element));
              return ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                itemCount: combinedList.length,
                itemBuilder: (context, index) {
                  if (combinedList[index] is LessonModel) {
                    LessonModel lesson = combinedList[index];
                    return Padding(
                      padding: EdgeInsets.all(_deviceQuery.safeWidth(2.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ListTile(
                          isThreeLine: true,
                          enableFeedback: true,
                          leading: Icon(
                            Icons.class__rounded,
                            color: CupertinoColors.activeOrange,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: _deviceQuery.safeWidth(4.0),
                            vertical: _deviceQuery.safeHeight(2.0),
                          ),
                          tileColor: _deviceQuery.brightness == Brightness.light
                              ? CupertinoColors.systemGroupedBackground
                              : CupertinoColors.darkBackgroundGray,
                          title: Text(
                            "${lesson.unit?.name}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(
                            "On: ${DateFormat('EEEE dd MMMM').format(lesson.startDate!)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "${DateFormat('hh:mm aa').format(lesson.startDate!)}"),
                              Text("TO"),
                              Text(
                                  "${DateFormat('hh:mm aa').format(lesson.endDate!)}")
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (combinedList[index] is AssignmentModel) {
                    AssignmentModel assignment = combinedList[index];
                    return CheckboxListTile(
                      value: assignment.isDone,
                      activeColor: CupertinoColors.activeBlue,
                      onChanged: (value) {},
                      tileColor: _deviceQuery.brightness == Brightness.light
                          ? CupertinoColors.systemGroupedBackground
                          : CupertinoColors.darkBackgroundGray,
                      title: Text(
                        "${assignment.description}",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              decoration: assignment.isDone ?? false
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: assignment.isDone ?? false
                                  ? Theme.of(context).disabledColor
                                  : null,
                            ),
                      ),
                    );
                  }
                  return NoDataFound(
                    message: 'No Lessons or Assignments Found',
                  );
                },
              );
            }
            return NoDataFound(message: 'No Data Found');
          },
        );
      },
    );
  }
}
