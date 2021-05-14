import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../data/models/task_model.dart';
import '../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../../logic/cubit/create_task/create_task_cubit.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';

/// # Create Task Form
/// The page can be used for both creating new tasks
/// and updating existing tasks
/// (By passing the task through the widget's constructor)
class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({TaskModel? task, required TasksBloc tasksBloc})
      : _task = task,
        _tasksBloc = tasksBloc;

  final TaskModel? _task;
  final TasksBloc _tasksBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _tasksBloc),
        BlocProvider<CreateTaskCubit>(
          create: (context) => CreateTaskCubit(),
        ),
      ],
      child: AddTaskFormView(_task),
    );
  }
}

class AddTaskFormView extends StatefulWidget {
  AddTaskFormView(this._task);

  final TaskModel? _task;

  @override
  _AddTaskFormViewState createState() => _AddTaskFormViewState();
}

class _AddTaskFormViewState extends State<AddTaskFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return FormView(
      title: widget._task == null ? "Create Task" : "Edit Task",
      actions: [
        BlocBuilder<CreateTaskCubit, CreateTaskState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  if (widget._task != null) {
                    context.read<TasksBloc>().add(
                          PersonalTaskUpdated(
                            widget._task!.copyWith(
                              title: _taskTitleController.text,
                            ),
                          ),
                        );
                  } else {
                    context.read<TasksBloc>().add(
                          PersonalTaskCreated(
                            title: _taskTitleController.text.trim(),
                          ),
                        );
                  }
                }
              },
              child: Text(
                widget._task == null ? "SAVE" : "UPDATE",
                textScaleFactor: 1.2,
              ),
            );
          },
        ),
      ],
      child: Column(
        children: [
          SizedBox(
            height: _deviceQuery.safeHeight(2.0),
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: CustomTextFormField(
              size: 2.8,
              label: 'Task',
              controller: _taskTitleController,
              keyboardType: TextInputType.text,
              validator: Validator.titleValidator,
            ),
          ),
        ],
      ),
    );
  }
}
