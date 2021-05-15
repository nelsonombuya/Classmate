import 'package:classmate/constants/device_query.dart';
import 'package:classmate/data/models/lesson_model.dart';

import 'package:classmate/logic/cubit/school/school_cubit.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:classmate/presentation/common_widgets/no_data_found.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

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
          stream: CombineLatestStream.list(state.lessonsStream),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasData && snapshot.data != null) {
              var combinedLessonList = [];
              snapshot.data!
                  .forEach((element) => combinedLessonList.addAll(element));
              return ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                itemCount: combinedLessonList.length,
                itemBuilder: (context, index) {
                  LessonModel currentLesson = combinedLessonList[index];
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
                          "${currentLesson.unit?.name}",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          "On: ${DateFormat('EEEE dd MMMM').format(currentLesson.startDate!)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "${DateFormat('hh:mm aa').format(currentLesson.startDate!)}"),
                            Text("TO"),
                            Text(
                                "${DateFormat('hh:mm aa').format(currentLesson.endDate!)}")
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return NoDataFound(message: 'No Lessons Found');
          },
        );
      },
    );
  }
}
