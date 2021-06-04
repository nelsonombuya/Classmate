import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart'
    as mapsPlacePicker;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:place_picker/place_picker.dart' as placePicker;

import '../../../data/models/task_model.dart';
import '../../bloc/tasks/tasks_bloc.dart';
import '../navigation/navigation_cubit.dart';
import '../notification/notification_cubit.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({
    required TasksBloc tasksBloc,
    required NavigationCubit navigationCubit,
    required NotificationCubit notificationCubit,
  })  : _tasksBloc = tasksBloc,
        _navigationCubit = navigationCubit,
        _notificationCubit = notificationCubit,
        super(CreateTaskState.initial());

  // TODO Hide Key
  final String apiKey = 'AIzaSyDmSoiXC2GHaQLpI_tcZaH2ArdRw2MlsG0';

  final formKey = GlobalKey<FormState>();
  final taskTitleController = TextEditingController();
  final taskTypes = <String>['Personal', 'Work', 'School'];

  final NavigationCubit _navigationCubit;
  final NotificationCubit _notificationCubit;
  final TasksBloc _tasksBloc;

  void _createNewTask() {
    return _tasksBloc.add(
      PersonalTaskCreated(
        dueDate: state.dueDate,
        taskType: state.taskType,
        locationName: state.locationName,
        title: taskTitleController.text.trim(),
        locationLatitude: state.latLng?.latitude,
        locationLongitude: state.latLng?.longitude,
      ),
    );
  }

  Future<LatLng> _getCurrentLocation() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        timeLimit: Duration(seconds: 10),
      );
      return LatLng(currentPosition.latitude, currentPosition.longitude);
    } catch (error) {
      this.addError(error);
      return LatLng(-0.303099, 36.080025); // Coordinates for Nakuru
    }
  }

  void _locationResultHandler(placePicker.LocationResult locationResult) {
    return _saveLocation(
      formattedAddress: locationResult.formattedAddress!,
      latLng: locationResult.latLng!,
    );
  }

  void _pickResultHandler(mapsPlacePicker.PickResult pickResult) {
    _navigationCubit.popCurrentPage();
    return _saveLocation(
      formattedAddress: pickResult.formattedAddress!,
      latLng: LatLng(
        pickResult.geometry!.location.lat,
        pickResult.geometry!.location.lng,
      ),
    );
  }

  void _saveLocation({
    required String formattedAddress,
    required LatLng latLng,
  }) {
    return emit(CreateTaskState.changed(
      latLng: LatLng(latLng.latitude, latLng.longitude),
      locationName: formattedAddress,
      taskType: state.taskType,
      dueDate: state.dueDate,
    ));
  }

  Future<void> _selectLocation(
    BuildContext context,
    LatLng initialLocation,
    Function(mapsPlacePicker.PickResult) selectedLocationHandler,
  ) async {
    // FIXME Have to press enter after search before selecting a place
    // ! Will otherwise throw a missing method error
    // FIXME Error thrown on hot reload
    // FIXME Fickle, Geolocation stops working sometimes
    return await showBarModalBottomSheet(
      context: context,
      builder: (context) => mapsPlacePicker.PlacePicker(
        apiKey: this.apiKey,
        onPlacePicked: selectedLocationHandler,
        initialPosition: initialLocation,
        useCurrentLocation: true,
      ),
    );
  }

  void _showGettingCurrentLocation() {
    return _notificationCubit.showAlert(
      "Getting Current Location",
      type: NotificationType.Loading,
    );
  }

  void _showSuccessGettingCurrentLocation() {
    return _notificationCubit.showAlert("Done", type: NotificationType.Success);
  }

  void _updateExistingTask(TaskModel task) {
    return _tasksBloc.add(
      PersonalTaskUpdated(
        task.copyWith(
          type: state.taskType,
          dueDate: state.dueDate,
          locationName: state.locationName,
          title: taskTitleController.text.trim(),
          locationLatitude: state.latLng?.latitude,
          locationLongitude: state.latLng?.longitude,
        ),
        popCurrentPage: true,
      ),
    );
  }

  void addLocation(BuildContext context) async {
    _showGettingCurrentLocation();
    var currentLocation = await _getCurrentLocation();
    _showSuccessGettingCurrentLocation();
    return await _selectLocation(
      context,
      currentLocation,
      _pickResultHandler,
    );
  }

  void addLocation2(BuildContext context) async {
    placePicker.LocationResult result = await showBarModalBottomSheet(
      context: context,
      builder: (context) => placePicker.PlacePicker(this.apiKey),
    );

    return _locationResultHandler(result);
  }

  void changeSelectedDueDate(DateTime date) {
    return emit(CreateTaskState.changed(
      dueDate: date,
      latLng: state.latLng,
      taskType: state.taskType,
      locationName: state.locationName,
    ));
  }

  void changeSelectedTaskType(String taskType) {
    return emit(CreateTaskState.changed(
      taskType: taskType,
      dueDate: state.dueDate,
      latLng: state.latLng,
      locationName: state.locationName,
    ));
  }

  void saveTask(TaskModel? task) {
    if (formKey.currentState!.validate()) {
      return task == null ? _createNewTask() : _updateExistingTask(task);
    }
  }

  void setTaskDetails(TaskModel task) {
    taskTitleController.text = task.title;
    return emit(CreateTaskState.changed(
      taskType: task.type,
      dueDate: task.dueDate,
      locationName: task.locationName,
      latLng: (task.locationLatitude != null && task.locationLongitude != null)
          ? LatLng(task.locationLatitude!, task.locationLongitude!)
          : null,
    ));
  }
}
