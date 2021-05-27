import 'package:classmate/logic/bloc/assignments/assignments_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../constants/device_query.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../logic/cubit/dashboard/dashboard_cubit.dart';
import '../../common_widgets/no_data_found.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(
        context.read<UserRepository>(),
        context.read<AssignmentsBloc>(),
      ),
      child: DashboardPageView(),
    );
  }
}

class DashboardPageView extends StatefulWidget {
  @override
  _DashboardPageViewState createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  @override
  Widget build(BuildContext context) {
    final _uid = context.read<UserRepository>().getCurrentUser()!.uid;
    final _cubit = context.read<DashboardCubit>();
    final _deviceQuery = DeviceQuery(context);

    return Padding(
      padding: EdgeInsets.all(_deviceQuery.safeWidth(4.0)),
      child: FutureBuilder<List<Stream<Unit?>>>(
        future: _cubit.getStreams(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (futureSnapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: futureSnapshot.data?.length,
              itemBuilder: (context, index) {
                return StreamBuilder<Unit?>(
                  stream: futureSnapshot.data![index],
                  builder: (context, snapshot) {
                    // ### Loading
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    // ### Loaded
                    if (snapshot.hasData) {
                      Unit unit = snapshot.data!;
                      var assignments = unit.assignments;
                      if (assignments!.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              unit.unitDetails!.name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: assignments.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  value:
                                      assignments[index].isDone?[_uid] ?? false,
                                  activeColor: CupertinoColors.activeBlue,
                                  onChanged: (value) =>
                                      _cubit.toggleAssignmentAsDone(
                                    uid: _uid,
                                    unit: unit,
                                    isDone: value!,
                                    assignment: assignments[index],
                                    index: index,
                                  ),
                                  tileColor: _deviceQuery.brightness ==
                                          Brightness.light
                                      ? CupertinoColors.systemGroupedBackground
                                      : CupertinoColors.darkBackgroundGray,
                                  title: Text(
                                    "${assignments[index].title}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          decoration: assignments[index]
                                                      .isDone?[_uid] ??
                                                  false
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: assignments[index]
                                                      .isDone?[_uid] ??
                                                  false
                                              ? Theme.of(context).disabledColor
                                              : null,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      // ### No Assignments
                      return NoDataFound(message: "No Assignments Found");
                    }
                    // ### No Classes nor Assignments
                    return NoDataFound(message: "You're Free");
                  },
                );
              },
            );
          }
          return NoDataFound(message: "Kindly register your units");
        },
      ),
    );
    // return BlocBuilder<SchoolCubit, SchoolState>(
    //   builder: (context, state) {
    //     return StreamBuilder<List>(
    //       stream: context.read<SchoolCubit>().getCombinedStreams(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(
    //             child: CircularProgressIndicator.adaptive(),
    //           );
    //         }

    //         if (snapshot.hasData && snapshot.data != null) {
    //           var combinedList = [];
    //           snapshot.data!.forEach((element) => combinedList.addAll(element));
    //           return ListView.builder(
    //             shrinkWrap: true,
    //             controller: _controller,
    //             itemCount: combinedList.length,
    //             itemBuilder: (context, index) {
    //               if (combinedList[index] is LessonModel) {
    //                 LessonModel lesson = combinedList[index];
    //                 return Padding(
    //                   padding: EdgeInsets.all(_deviceQuery.safeWidth(2.0)),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(8.0),
    //                     child: ListTile(
    //                       isThreeLine: true,
    //                       enableFeedback: true,
    //                       leading: Icon(
    //                         Icons.class__rounded,
    //                         color: CupertinoColors.activeOrange,
    //                       ),
    //                       contentPadding: EdgeInsets.symmetric(
    //                         horizontal: _deviceQuery.safeWidth(4.0),
    //                         vertical: _deviceQuery.safeHeight(2.0),
    //                       ),
    //                       tileColor: _deviceQuery.brightness == Brightness.light
    //                           ? CupertinoColors.systemGroupedBackground
    //                           : CupertinoColors.darkBackgroundGray,
    //                       title: Text(
    //                         "${lesson.unitName}",
    //                         style: Theme.of(context).textTheme.headline6,
    //                       ),
    //                       subtitle: Text(
    //                         "On: ${DateFormat('EEEE dd MMMM').format(lesson.startDate)}",
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                       trailing: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           Text(
    //                               "${DateFormat('hh:mm aa').format(lesson.startDate)}"),
    //                           Text("TO"),
    //                           Text(
    //                               "${DateFormat('hh:mm aa').format(lesson.endDate)}")
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }
    //               if (combinedList[index] is AssignmentModel) {
    //                 AssignmentModel assignment = combinedList[index];
    //                 return CheckboxListTile(
    //                   value: false,
    //                   activeColor: CupertinoColors.activeBlue,
    //                   onChanged: (value) {},
    //                   tileColor: _deviceQuery.brightness == Brightness.light
    //                       ? CupertinoColors.systemGroupedBackground
    //                       : CupertinoColors.darkBackgroundGray,
    //                   title: Text(
    //                     "${assignment.description}",
    //                     style: Theme.of(context).textTheme.headline6!.copyWith(
    //                           decoration: assignment.isDone?[_uid] ?? false
    //                               ? TextDecoration.lineThrough
    //                               : null,
    //                           color: assignment.isDone?[_uid] ?? false
    //                               ? Theme.of(context).disabledColor
    //                               : null,
    //                         ),
    //                   ),
    //                 );
    //               }
    //               return NoDataFound(
    //                 message: 'No Lessons or Assignments Found',
    //               );
    //             },
    //           );
    //         }
    //         return NoDataFound(message: 'No Data Found');
    //       },
    //     );
    //   },
    // );
  }
}
