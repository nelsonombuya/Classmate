import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/device_query.dart';
import '../../../data/models/task_model.dart';
import '../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../common_widgets/no_data_found.dart';
import 'create_task.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final ScrollController _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final TasksBloc _tasksBloc = context.read<TasksBloc>();

    return StreamBuilder<List<TaskModel>>(
      stream: _tasksBloc.personalTaskDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<TaskModel> tasks = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            controller: _listViewScrollController,
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
                          tasksBloc: _tasksBloc,
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
                      onPressed: () => context
                          .read<NotificationCubit>()
                          .showDeleteDialog(
                              DialogType.DeleteTask,
                              () => _tasksBloc
                                  .add(PersonalTaskDeleted(tasks[index]))),
                    ),
                  ],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CheckboxListTile(
                      value: tasks[index].isDone,
                      activeColor: CupertinoColors.activeBlue,
                      onChanged: (value) {
                        _tasksBloc.add(
                          PersonalTaskUpdated(
                            tasks[index].copyWith(isDone: value),
                            silentUpdate: true,
                          ),
                        );
                      },
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
                    ),
                  ),
                ),
              );
            },
          );
        }
        return NoDataFound(message: "No Tasks Found");
      },
    );
  }
}
