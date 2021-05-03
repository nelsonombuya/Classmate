import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../bloc/notification/notification_bloc.dart';
import '../../../bloc/task/task_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../data/models/task_model.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final ScrollController _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);
    final NotificationBloc _notificationBloc =
        BlocProvider.of<NotificationBloc>(context);

    return StreamBuilder<List<TaskModel>>(
      stream: _taskBloc.personalTaskDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasData) {
          List<TaskModel> tasks = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            controller: _listViewScrollController,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                        onTap: () {},
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        icon: Icons.delete_rounded,
                        color: Theme.of(context).errorColor,
                        onTap: () => _notificationBloc.add(
                          DeleteDialogBoxRequested(
                            context,
                            () => _taskBloc.add(
                              PersonalTaskDeleted(tasks[index]),
                            ),
                          ),
                        ),
                      ),
                    ],
                    child: CheckboxListTile(
                      value: tasks[index].isDone,
                      activeColor: CupertinoColors.activeBlue,
                      onChanged: (value) {
                        if (value == null) {
                          throw Exception(
                              "The checked value shouldn't be null ❗");
                        }

                        tasks[index].isDone = value;
                        _taskBloc.add(PersonalTaskUpdated(tasks[index]));
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¯\\_( ͡° ͜ʖ ͡°)_/¯",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontFamily: "Noto"),
            ),
            SizedBox(height: _deviceQuery.safeHeight(4.0)),
            Text(
              "No Events Found",
              style: Theme.of(context).textTheme.headline5!,
            ),
          ],
        );
      },
    );
  }
}
