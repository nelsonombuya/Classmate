import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../data/models/task_model.dart';
import '../../../logic/bloc/tasks/tasks_bloc.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';
import 'add_location.dart';

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
    return BlocProvider.value(
      value: _tasksBloc,
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskTitleController = TextEditingController();
  final LatLng nakuru = LatLng(0, 0);

  Future<LatLng> _getCurrentLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) => position);
    return LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return FormView(
      title: widget._task == null ? "Create Task" : "Edit Task",
      actions: [
        TextButton(
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
        ),
      ],
      child: Column(
        children: [
          SizedBox(height: _deviceQuery.safeHeight(2.0)),
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
          TextButton.icon(
            label: Text('Add a location'),
            icon: Icon(Icons.add_location_rounded),
            onPressed: () => showBarModalBottomSheet(
              context: context,
              builder: (context) => PlacePicker(
                apiKey: 'AIzaSyDmSoiXC2GHaQLpI_tcZaH2ArdRw2MlsG0',
                onPlacePicked: (result) {
                  Logger().wtf(result);
                  Navigator.of(context).pop();
                },
                initialPosition: nakuru,
                useCurrentLocation: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
