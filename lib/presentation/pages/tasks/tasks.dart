import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../../../bloc/task/task_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../data/models/task_model.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);

    return StreamBuilder<List<TaskModel>>(
      stream: _taskBloc.taskDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceQuery.safeWidth(4.0),
                vertical: _deviceQuery.safeHeight(1.0),
              ),
              child: FocusedMenuHolder(
                blurSize: 0.0,
                menuOffset: 10.0,
                menuItemExtent: 45,
                animateMenuItems: true,
                bottomOffsetHeight: 80.0,
                blurBackgroundColor: Colors.black54,
                duration: Duration(milliseconds: 100),
                menuWidth: MediaQuery.of(context).size.width * 0.50,
                menuBoxDecoration: BoxDecoration(
                  color: CupertinoColors.systemGroupedBackground,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                menuItems: <FocusedMenuItem>[
                  FocusedMenuItem(
                    title: Text("Details"),
                    trailingIcon: Icon(Icons.open_in_new_rounded),
                    onPressed: () {},
                  ),
                  FocusedMenuItem(
                    title: Text("Edit"),
                    trailingIcon: Icon(Icons.edit_rounded),
                    onPressed: () {},
                  ),
                  FocusedMenuItem(
                    title: Text(
                      "Delete",
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    trailingIcon: Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () {},
                  ),
                ],
                onPressed: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CheckboxListTile(
                    value: snapshot.data![index].isDone,
                    onChanged: (value) {},
                    tileColor: CupertinoColors.systemGroupedBackground,
                    title: Text(
                      "${snapshot.data![index].title}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
