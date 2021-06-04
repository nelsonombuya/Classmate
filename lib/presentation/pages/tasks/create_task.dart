import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../data/models/task_model.dart';
import '../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../../logic/cubit/create_task/create_task_cubit.dart';
import '../../../logic/cubit/navigation/navigation_cubit.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/date_picker_button.dart';
import '../../common_widgets/form_view.dart';

/// # Create Task Form
/// The page can be used for both creating new tasks
/// and updating existing tasks
/// (By passing the task through the widget's constructor)
class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({
    TaskModel? task,
    required TasksBloc tasksBloc,
    required NavigationCubit navigationCubit,
    required NotificationCubit notificationCubit,
  })  : _task = task,
        _tasksBloc = tasksBloc,
        _navigationCubit = navigationCubit,
        _notificationCubit = notificationCubit;

  final TaskModel? _task;
  final TasksBloc _tasksBloc;
  final NavigationCubit _navigationCubit;
  final NotificationCubit _notificationCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskCubit(
        tasksBloc: _tasksBloc,
        navigationCubit: _navigationCubit,
        notificationCubit: _notificationCubit,
      ),
      child: CreateTaskFormView(_task),
    );
  }
}

class CreateTaskFormView extends StatefulWidget {
  CreateTaskFormView(this._task);

  final TaskModel? _task;

  @override
  _CreateTaskFormViewState createState() => _CreateTaskFormViewState();
}

class _CreateTaskFormViewState extends State<CreateTaskFormView> {
  @override
  void initState() {
    super.initState();
    if (widget._task != null) {
      context.read<CreateTaskCubit>().setTaskDetails(widget._task!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<CreateTaskCubit>();
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return FormView(
      title: widget._task == null ? "Create Task" : "Edit Task",
      actions: [
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            _cubit.saveTask(widget._task);
          },
          child: Text(
            widget._task == null ? "SAVE" : "UPDATE",
            textScaleFactor: 1.2,
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: _deviceQuery.safeHeight(2.0)),
          Form(
            key: _cubit.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: CustomTextFormField(
              size: 2.8,
              label: 'Task',
              keyboardType: TextInputType.text,
              validator: Validator.titleValidator,
              controller: _cubit.taskTitleController,
            ),
          ),
          SizedBox(height: _deviceQuery.safeHeight(2.0)),
          DropdownButtonFormField<String>(
            value: _cubit.state.taskType,
            onChanged: (type) => _cubit.changeSelectedTaskType(type!),
            items: _cubit.taskTypes
                .map((type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
          ),
          SizedBox(height: _deviceQuery.safeHeight(3.0)),
          BlocBuilder<CreateTaskCubit, CreateTaskState>(
            builder: (context, state) {
              return DatePickerButton(
                title: 'Due Date',
                overrideDateWithText:
                    state.dueDate != null ? null : 'Tap to add',
                overrideTimeWithText: state.dueDate != null ? null : '',
                onTap: (date) => _cubit.changeSelectedDueDate(date),
                selectedDate: _cubit.state.dueDate ?? DateTime.now(),
              );
            },
          ),
          SizedBox(height: _deviceQuery.safeHeight(2.0)),
          BlocBuilder<CreateTaskCubit, CreateTaskState>(
            builder: (context, state) {
              return TextButton.icon(
                label: Text(state.locationName ?? 'Add a location'),
                onPressed: () => _cubit.addLocation(context),
                onLongPress: () => _cubit.addLocation2(context),
                icon: Icon(Icons.add_location_rounded),
              );
            },
          ),
        ],
      ),
    );
  }
}
