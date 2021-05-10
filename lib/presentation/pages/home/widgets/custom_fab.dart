import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../bloc/events/events_bloc.dart';
import '../../../../bloc/tasks/tasks_bloc.dart';
import '../../../../constants/device_query.dart';
import '../../events/create_event.dart';
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
            builder: (context) => CreateEvent(
              eventsBloc: context.read<EventsBloc>(),
            ),
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
            builder: (context) => CreateTaskForm(
              tasksBloc: context.read<TasksBloc>(),
            ),
          ),
        ),
      ],
    );
  }
}
