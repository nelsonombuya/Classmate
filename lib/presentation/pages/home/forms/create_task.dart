import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/task/task_bloc.dart';
import '../../../../constants/device_query.dart';
import '../../../../constants/validator.dart';
import '../../../../cubit/create_task/create_task_cubit.dart';
import '../../../common_widgets/custom_textFormField.dart';
import '../../../common_widgets/form_view.dart';

class CreateTaskForm extends StatelessWidget {
  final bool edit;

  CreateTaskForm({this.edit = false});

  @override
  Widget build(BuildContext context) {
    return DeviceQuery(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider<CreateTaskCubit>(
            create: (context) => CreateTaskCubit(),
          ),
          BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(context),
          ),
        ],
        child: AddTaskFormView(edit),
      ),
    );
  }
}

class AddTaskFormView extends StatefulWidget {
  final bool edit;

  AddTaskFormView(this.edit);

  @override
  _AddTaskFormViewState createState() => _AddTaskFormViewState();
}

class _AddTaskFormViewState extends State<AddTaskFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);
    final CreateTaskCubit _createTaskCubit =
        BlocProvider.of<CreateTaskCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateTaskCubit, CreateTaskState>(
          listener: (context, state) {
            if (state is TaskValidation) {
              if (_formKey.currentState == null)
                throw Exception("Current Form State is Null ❗ ");

              if (_formKey.currentState!.validate()) {
                _taskBloc.add(
                  PersonalTaskCreated(
                    title: _taskTitleController.text.trim(),
                  ),
                );
              }
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskAddedSuccessfully) Navigator.of(context).pop();
          },
        ),
      ],
      child: FormView(
        title: "Create Task",
        actions: [
          TextButton.icon(
            onPressed: () {
              _createTaskCubit.validateNewTask();
              FocusScope.of(context).unfocus();
            },
            icon: Icon(Icons.save_rounded),
            label: Text("SAVE"),
          ),
        ],
        child: Column(
          children: [
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
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
      ),
    );
  }
}
