part of 'create_task_cubit.dart';

class CreateTaskState extends Equatable {
  const CreateTaskState._({
    this.taskType = 'Personal',
    this.locationName,
    this.dueDate,
    this.latLng,
  });

  const CreateTaskState.changed({
    required this.taskType,
    this.locationName,
    this.dueDate,
    this.latLng,
  });

  const CreateTaskState.initial() : this._();

  final String taskType;
  final DateTime? dueDate;
  final LatLng? latLng;
  final String? locationName;

  @override
  List<Object> get props => [
        dueDate ?? 'No Due Date Set',
        "$taskType task",
        locationName ?? "No Location Set",
        latLng ?? "No Location Co-ordinates Set"
      ];
}
