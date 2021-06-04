import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/task_model.dart';
import '../../../logic/cubit/tasks_page/tasks_page_cubit.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    Key? key,
    required this.task,
    required this.tasksPageCubit,
  }) : super(key: key);

  final TaskModel task;
  final TasksPageCubit tasksPageCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskType(task: task, tasksPageCubit: tasksPageCubit),
        SizedBox(height: 8),
        if (task.dueDate != null) DueDate(task: task),
        SizedBox(height: 8),
        if (task.locationName != null) LocationName(task: task),
        SizedBox(height: 8),
        if (task.locationName != null)
          DistanceFromUser(tasksPageCubit: tasksPageCubit, task: task),
      ],
    );
  }
}

class TaskType extends StatelessWidget {
  const TaskType({
    Key? key,
    required this.task,
    required this.tasksPageCubit,
  }) : super(key: key);

  final TaskModel task;
  final TasksPageCubit tasksPageCubit;

  @override
  Widget build(BuildContext context) {
    return Text(
      task.type,
      style: TextStyle(color: tasksPageCubit.setTaskTypeColor(task.type)),
    );
  }
}

class DueDate extends StatelessWidget {
  const DueDate({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer_rounded,
          size: 16.0,
          color: task.dueDate!.isBefore(DateTime.now())
              ? Theme.of(context).errorColor
              : null,
        ),
        SizedBox(width: 2),
        Text(
          "Due: ${DateFormat('EEE dd MMM hh:mm aa').format(task.dueDate!)}",
          style: TextStyle(
            color: task.dueDate!.isBefore(DateTime.now())
                ? Theme.of(context).errorColor
                : null,
          ),
        ),
      ],
    );
  }
}

class LocationName extends StatelessWidget {
  const LocationName({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: 16.0,
          color: CupertinoColors.inactiveGray,
        ),
        SizedBox(width: 2),
        Text("${task.locationName}"),
        SizedBox(width: 2),
      ],
    );
  }
}

class DistanceFromUser extends StatelessWidget {
  const DistanceFromUser({
    Key? key,
    required this.task,
    required this.tasksPageCubit,
  }) : super(key: key);

  final TasksPageCubit tasksPageCubit;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.social_distance_rounded,
          size: 16.0,
          color: CupertinoColors.inactiveGray,
        ),
        SizedBox(width: 2),
        FutureBuilder<String>(
          future: tasksPageCubit.getDistanceFromMyCurrentLocation(
            task.locationLatitude!,
            task.locationLongitude!,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data ?? "Unknown");
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
