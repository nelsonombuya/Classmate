import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/tasks/tasks_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../cubit/create_task/create_task_cubit.dart';
import '../../../data/models/task_model.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({this.task, required this.tasksBloc});

  final TaskModel? task;
  final TasksBloc tasksBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: tasksBloc),
        BlocProvider<CreateTaskCubit>(
          create: (context) => CreateTaskCubit(),
        ),
      ],
      child: AddTaskFormView(task),
    );
  }
}

class AddTaskFormView extends StatefulWidget {
  AddTaskFormView(this.task);

  final TaskModel? task;

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
      title: widget.task == null ? "Create Task" : "Edit Task",
      actions: [
        BlocBuilder<CreateTaskCubit, CreateTaskState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  if (widget.task != null) {
                    context.read<TasksBloc>().add(PersonalTaskUpdated(widget
                        .task!
                        .copyWith(title: _taskTitleController.text)));
                  } else {
                    context.read<TasksBloc>().add(PersonalTaskCreated(
                        title: _taskTitleController.text.trim()));
                  }
                }
              },
              child: Text("SAVE"),
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
              size: 3.0,
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
