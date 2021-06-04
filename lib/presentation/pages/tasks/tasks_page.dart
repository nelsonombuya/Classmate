import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/task_model.dart';
import '../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../../logic/cubit/location/location_cubit.dart';
import '../../../logic/cubit/navigation/navigation_cubit.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../../logic/cubit/tasks_page/tasks_page_cubit.dart';
import '../../common_widgets/no_data_found.dart';
import 'tasks_list_view.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksPageCubit(
        tasksBloc: context.read<TasksBloc>(),
        locationCubit: LocationCubit(),
      ),
      child: Builder(
        builder: (context) => StreamBuilder<List<TaskModel>>(
          stream: context.watch<TasksPageCubit>().getTasksStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return TasksListView(
                tasks: snapshot.data!,
                tasksBloc: context.watch<TasksBloc>(),
                tasksPageCubit: context.watch<TasksPageCubit>(),
                navigationCubit: context.watch<NavigationCubit>(),
                notificationCubit: context.watch<NotificationCubit>(),
              );
            }
            return NoDataFound(message: "No Tasks Found");
          },
        ),
      ),
    );
  }
}
