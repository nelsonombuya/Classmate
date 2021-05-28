import 'package:classmate/data/repositories/school_repository.dart';
import 'package:classmate/logic/bloc/assignments/assignments_bloc.dart';
import 'package:classmate/logic/cubit/notification/notification_cubit.dart';
import 'package:classmate/presentation/pages/assignments/create_assignment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    final _assignmentsBloc = context.read<AssignmentsBloc>();
    final _schoolRepository = context.read<SchoolRepository>();
    final _userRepository = context.read<UserRepository>();
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
                      var lessons = unit.lessons;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            unit.unitDetails!.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 10),
                          if (lessons!.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: lessons.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(
                                      _deviceQuery.safeWidth(2.0)),
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
                                      tileColor: _deviceQuery.brightness ==
                                              Brightness.light
                                          ? CupertinoColors
                                              .systemGroupedBackground
                                          : CupertinoColors.darkBackgroundGray,
                                      title: Text(
                                        "${lessons[index].title}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      subtitle: Text(
                                        "On: ${DateFormat('EEEE dd MMMM').format(lessons[index].startDate)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "${DateFormat('hh:mm aa').format(lessons[index].startDate)}"),
                                          Text("TO"),
                                          Text(
                                              "${DateFormat('hh:mm aa').format(lessons[index].endDate)}")
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          if (assignments!.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: assignments.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(
                                    _deviceQuery.safeWidth(1.5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Slidable(
                                      actionPane: SlidableBehindActionPane(),
                                      actionExtentRatio: 0.25,
                                      actions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Edit',
                                          icon: Icons.edit_rounded,
                                          color: CupertinoColors.activeBlue,
                                          onTap: () => showBarModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CreateAssignmentForm(
                                              unit: unit,
                                              index: index,
                                              assignment: assignments[index],
                                              assignmentsBloc: _assignmentsBloc,
                                              schoolRepository:
                                                  _schoolRepository,
                                              userRepository: _userRepository,
                                            ),
                                          ),
                                        ),
                                      ],
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Delete',
                                          icon: Icons.delete_rounded,
                                          color: Theme.of(context).errorColor,
                                          onTap: () => context
                                              .read<NotificationCubit>()
                                              .showDeleteDialog(
                                                DialogType.DeleteAssignment,
                                                () => _cubit.deleteAssignment(
                                                  unit: unit,
                                                  index: index,
                                                ),
                                              ),
                                        ),
                                      ],
                                      child: CheckboxListTile(
                                        isThreeLine: true,
                                        value:
                                            assignments[index].isDone?[_uid] ??
                                                false,
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
                                            ? CupertinoColors
                                                .systemGroupedBackground
                                            : CupertinoColors
                                                .darkBackgroundGray,
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
                                                    ? Theme.of(context)
                                                        .disabledColor
                                                    : null,
                                              ),
                                        ),
                                        subtitle: Text(
                                            "${assignments[index].description}\nDue : ${DateFormat('EEEE dd MMMM hh:mm aa').format(assignments[index].dueDate)}"),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    }
                    // ### No Assignments
                    return NoDataFound(
                      message: "No Assignments or Classes Found",
                    );
                  },
                );
              },
            );
          }
          return NoDataFound(message: "Kindly register your units");
        },
      ),
    );
  }
}
