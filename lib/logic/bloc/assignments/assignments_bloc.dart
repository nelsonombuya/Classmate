import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/assignment_model.dart';
import '../../../data/models/unit_details_model.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/repositories/unit_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../cubit/navigation/navigation_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';

part 'assignments_event.dart';
part 'assignments_state.dart';

class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  AssignmentsBloc({
    required NotificationCubit notificationCubit,
    required NavigationCubit navigationCubit,
    required UserRepository userRepository,
  })  : _notificationCubit = notificationCubit,
        _navigationCubit = navigationCubit,
        _userRepository = userRepository,
        super(AssignmentsState.initial());

  final NavigationCubit _navigationCubit;
  final NotificationCubit _notificationCubit;
  final UserRepository _userRepository;

  @override
  Stream<AssignmentsState> mapEventToState(AssignmentsEvent event) async* {
    if (event is AssignmentCreated) {
      yield* _mapAssignmentCreatedToState(event);
    } else if (event is AssignmentUpdated) {
      yield* _mapAssignmentUpdatedToState(event);
    } else if (event is AssignmentDeleted) {
      yield* _mapAssignmentDeletedToState(event);
    }
  }

  Future<Unit> _getUnitDetails(
    UnitRepository unitRepository,
    AssignmentCreated event,
    String sessionID,
  ) async {
    return await unitRepository.getUnit(event.unit.id) ??
        Unit(
          id: event.unit.id,
          unitDetails: event.unit,
          sessionId: sessionID,
          assignments: [],
          lessons: [],
        );
  }

  Future<UnitRepository> _getUnitRepository() async {
    var userData = await _userRepository.getUserData();
    var unitRepository = UnitRepository(
      schoolID: userData.schoolId!,
      sessionID: userData.sessionId!,
    );
    return unitRepository;
  }

  Stream<AssignmentsState> _mapAssignmentCreatedToState(
    AssignmentCreated event,
  ) async* {
    try {
      _showCreatingAssignmentNotification();
      var assignment = _mapEventToAssignment(event);
      var userData = await _userRepository.getUserData();
      var unitRepository = UnitRepository(
        schoolID: userData.schoolId!,
        sessionID: userData.sessionId!,
      );
      Unit currentUnitDetails = await _getUnitDetails(
        unitRepository,
        event,
        userData.sessionId!,
      );
      currentUnitDetails.assignments!.add(assignment);
      await unitRepository.updateUnit(currentUnitDetails);
      _showAssignmentCreatedSuccessfullyNotification();
      _navigationCubit.popCurrentPage();
      yield AssignmentsState.updated(assignment: assignment);
    } catch (e) {
      _showErrorCreatingAssignmentNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<AssignmentsState> _mapAssignmentDeletedToState(
    AssignmentDeleted event,
  ) async* {
    try {
      _showDeletingAssignmentNotification();
      UnitRepository unitRepository = await _getUnitRepository();
      await unitRepository.updateUnit(event.unit);
      _showAssignmentDeletedSuccessfullyNotification();
      yield AssignmentsState.deleted(assignment: event.assignment);
    } catch (e) {
      _showErrorDeletingAssignmentNotification(e.toString());
      this.addError(e);
    }
  }

  Stream<AssignmentsState> _mapAssignmentUpdatedToState(
    AssignmentUpdated event,
  ) async* {
    try {
      if (!event.silentUpdate) _showUpdatingAssignmentNotification();
      UnitRepository unitRepository = await _getUnitRepository();
      await unitRepository.updateUnit(event.unit);
      if (!event.silentUpdate) _showAssignmentUpdatedSuccessfullyNotification();
      if (!event.silentUpdate) _navigationCubit.popCurrentPage();
      yield AssignmentsState.updated(assignment: event.assignment);
    } catch (e) {
      _showErrorUpdatingAssignmentNotification(e.toString());
      this.addError(e);
    }
  }

  Assignment _mapEventToAssignment(AssignmentCreated event) {
    return Assignment(
      description: event.description,
      dueDate: event.dueDate,
      title: event.title,
    );
  }

  void _showAssignmentCreatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Assignment Created",
      type: NotificationType.Success,
    );
  }

  void _showAssignmentDeletedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Assignment Deleted",
      type: NotificationType.Success,
    );
  }

  void _showAssignmentUpdatedSuccessfullyNotification() {
    return _notificationCubit.showAlert(
      "Assignment Updated",
      type: NotificationType.Success,
    );
  }

  // ## Notifications
  void _showCreatingAssignmentNotification() {
    return _notificationCubit.showAlert(
      "Creating Assignment",
      type: NotificationType.Loading,
    );
  }

  void _showDeletingAssignmentNotification() {
    return _notificationCubit.showAlert(
      "Deleting Assignment",
      type: NotificationType.Loading,
    );
  }

  void _showErrorCreatingAssignmentNotification(String message) {
    _notificationCubit.showAlert(
      "Error Creating Assignment",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Creating Assignment",
      type: NotificationType.Danger,
    );
  }

  void _showErrorDeletingAssignmentNotification(String message) {
    _notificationCubit.showAlert(
      "Error Deleting Assignment",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Deleting Assignment",
      type: NotificationType.Danger,
    );
  }

  void _showErrorUpdatingAssignmentNotification(String message) {
    _notificationCubit.showAlert(
      "Error Updating Assignment",
      type: NotificationType.Danger,
    );
    return _notificationCubit.showSnackBar(
      message,
      title: "Error Updating Assignment",
      type: NotificationType.Danger,
    );
  }

  void _showUpdatingAssignmentNotification() {
    return _notificationCubit.showAlert(
      "Updating Assignment",
      type: NotificationType.Loading,
    );
  }
}
