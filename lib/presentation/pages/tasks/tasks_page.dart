import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
                          builder: (context) => CreateTaskForm(
                            task: tasks[index],
                            tasksBloc: _tasksBloc,
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
                                DialogType.DeleteTask,
                                // * If the dialog is accepted
                                // * It will send an event deleted request
                                () => _tasksBloc
                                    .add(PersonalTaskDeleted(tasks[index]))),
                      ),
                    ],
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
