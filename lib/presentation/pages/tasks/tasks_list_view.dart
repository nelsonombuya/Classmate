import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/device_query.dart';
import '../../../data/models/task_model.dart';
import '../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../../logic/cubit/navigation/navigation_cubit.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../../logic/cubit/tasks_page/tasks_page_cubit.dart';
import 'create_task.dart';
import 'widgets.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    Key? key,
    required this.tasks,
    required this.tasksBloc,
    required this.tasksPageCubit,
    required this.navigationCubit,
    required this.notificationCubit,
  }) : super(key: key);

  final NavigationCubit navigationCubit;
  final NotificationCubit notificationCubit;
  final List<TaskModel> tasks;
  final TasksBloc tasksBloc;
  final TasksPageCubit tasksPageCubit;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(_deviceQuery.safeWidth(1.5)),
          child: FocusedMenuHolder(
            blurSize: 5.0,
            menuOffset: 10.0,
            onPressed: () {},
            menuItemExtent: 45,
            animateMenuItems: true,
            bottomOffsetHeight: 80.0,
            blurBackgroundColor: Colors.black54,
            duration: Duration(milliseconds: 100),
            menuWidth: MediaQuery.of(context).size.width * 0.50,
            menuBoxDecoration: BoxDecoration(
              color: _deviceQuery.brightness == Brightness.light
                  ? CupertinoColors.systemGroupedBackground
                  : CupertinoColors.darkBackgroundGray,
              borderRadius: BorderRadius.circular(15.0),
            ),
            menuItems: <FocusedMenuItem>[
              FocusedMenuItem(
                title: Text(
                  "Edit Task Details",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                trailingIcon: Icon(
                  Icons.edit_rounded,
                  color: CupertinoColors.activeBlue,
                ),
                onPressed: () => showBarModalBottomSheet(
                  context: context,
                  builder: (context) => CreateTaskForm(
                    task: tasks[index],
                    tasksBloc: tasksBloc,
                    navigationCubit: navigationCubit,
                    notificationCubit: notificationCubit,
                  ),
                ),
              ),
              FocusedMenuItem(
                title: Text(
                  "Delete Task",
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
                trailingIcon: Icon(
                  Icons.delete_rounded,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => notificationCubit.showDeleteDialog(
                  DialogType.DeleteTask,
                  () => tasksPageCubit.deleteTask(tasks[index]),
                ),
              ),
            ],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CheckboxListTile(
                // FIXME Weird Effects after updating task
                // FIXME Distances changing after update
                isThreeLine: true,
                value: tasks[index].isDone,
                activeColor: CupertinoColors.activeBlue,
                onChanged: (value) =>
                    tasksPageCubit.toggleTaskDone(tasks[index], value!),
                tileColor: _deviceQuery.brightness == Brightness.light
                    ? CupertinoColors.systemGroupedBackground
                    : CupertinoColors.darkBackgroundGray,
                title: Text(
                  "${tasks[index].title}",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : null,
                        color: tasks[index].isDone
                            ? Theme.of(context).disabledColor
                            : null,
                      ),
                ),
                subtitle: TaskDetails(
                  task: tasks[index],
                  tasksPageCubit: tasksPageCubit,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
