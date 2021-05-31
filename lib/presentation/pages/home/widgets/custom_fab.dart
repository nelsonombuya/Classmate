import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../constants/device_query.dart';
import '../../../../data/models/user_data_model.dart';
import '../../../../data/repositories/school_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../logic/bloc/assignments/assignments_bloc.dart';
import '../../../../logic/bloc/events/events_bloc.dart';
import '../../../../logic/bloc/lessons/lessons_bloc.dart';
import '../../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../assignments/create_assignment.dart';
import '../../events/create_event.dart';
import '../../lessons/create_lessons.dart';
import '../../tasks/create_task.dart';

/// # Custom Floating Action Button
/// Allows the user to view the following forms:
///   - Add New Event
///   - Add New Task
/// ! Depends on Speed Dial Package
class CustomFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    Color _fabColor = _deviceQuery.brightness == Brightness.light
        ? CupertinoColors.systemGroupedBackground
        : CupertinoColors.darkBackgroundGray;

    Color _labelColor = _deviceQuery.brightness == Brightness.light
        ? CupertinoColors.black
        : CupertinoColors.white;

    final UserRepository _userRepository = context.read<UserRepository>();
    final _schoolRepository = context.read<SchoolRepository>();
    final _assignmentsBloc = context.read<AssignmentsBloc>();
    final _lessonsBloc = context.read<LessonsBloc>();

    final TasksBloc _tasksBloc = context.read<TasksBloc>();
    final EventsBloc _eventsBloc = context.read<EventsBloc>();

    return FutureBuilder<UserData?>(
      future: _userRepository.getUserData(),
      builder: (context, snapshot) {
        return SpeedDial(
          tooltip: "Quick Actions",
          backgroundColor: _fabColor,
          foregroundColor: _labelColor,
          curve: Curves.fastLinearToSlowEaseIn,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              label: "New Event",
              backgroundColor: _fabColor,
              labelBackgroundColor: _fabColor,
              labelStyle: TextStyle(color: _labelColor),
              child: Icon(Icons.event, color: _labelColor),
              onTap: () => showBarModalBottomSheet(
                context: context,
                builder: (context) => CreateEvent(eventsBloc: _eventsBloc),
              ),
            ),
            SpeedDialChild(
              label: "New Task",
              backgroundColor: _fabColor,
              labelBackgroundColor: _fabColor,
              labelStyle: TextStyle(color: _labelColor),
              child: Icon(Icons.list_rounded, color: _labelColor),
              onTap: () => showBarModalBottomSheet(
                context: context,
                builder: (context) => CreateTaskForm(tasksBloc: _tasksBloc),
              ),
            ),
            SpeedDialChild(
              label: "New Assignment",
              backgroundColor: _fabColor,
              labelBackgroundColor: _fabColor,
              labelStyle: TextStyle(color: _labelColor),
              child: Icon(Icons.assignment_rounded, color: _labelColor),
              onTap: () => showBarModalBottomSheet(
                context: context,
                builder: (context) => CreateAssignmentForm(
                  schoolRepository: _schoolRepository,
                  userRepository: _userRepository,
                  assignmentsBloc: _assignmentsBloc,
                ),
              ),
            ),
            SpeedDialChild(
              label: "New Lesson",
              backgroundColor: _fabColor,
              labelBackgroundColor: _fabColor,
              labelStyle: TextStyle(color: _labelColor),
              child: Icon(Icons.assignment_rounded, color: _labelColor),
              onTap: () => showBarModalBottomSheet(
                context: context,
                builder: (context) => CreateLessonForm(
                  schoolRepository: _schoolRepository,
                  userRepository: _userRepository,
                  lessonsBloc: _lessonsBloc,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
