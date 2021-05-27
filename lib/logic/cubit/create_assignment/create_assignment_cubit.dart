import 'package:bloc/bloc.dart';
import '../../../constants/validator.dart';
import '../../../data/models/unit_details_model.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../bloc/assignments/assignments_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

part 'create_assignment_state.dart';

class CreateAssignmentCubit extends Cubit<CreateAssignmentState> {
  CreateAssignmentCubit({
    required UserRepository userRepository,
    required AssignmentsBloc assignmentsBloc,
    required SchoolRepository schoolRepository,
  })   : _userRepository = userRepository,
        _assignmentsBloc = assignmentsBloc,
        _schoolRepository = schoolRepository,
        super(CreateAssignmentState.initial(selectedDueDate: DateTime.now()));

  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final titleValidator = Validator.titleValidator;

  final AssignmentsBloc _assignmentsBloc;
  final AsyncMemoizer<List<UnitDetails?>> _memoizer = AsyncMemoizer();
  final SchoolRepository _schoolRepository;
  final UserRepository _userRepository;

  void changeSelectedDate(DateTime selectedDueDate) {
    return emit(CreateAssignmentState.changed(
      selectedDueDate: selectedDueDate,
      unit: state.unit,
    ));
  }

  void changeSelectedUnit(UnitDetails unit) {
    return emit(CreateAssignmentState.changed(
      selectedDueDate: state.selectedDueDate,
      unit: unit,
    ));
  }

  Future<List<UnitDetails?>> getRegisteredUnits() {
    return _memoizer.runOnce(_getListOfRegisteredUnits);
  }

  Future<List<UnitDetails?>> _getListOfRegisteredUnits() async {
    var userData = await _userRepository.getUserData();
    if (userData.registeredUnitIds == null && userData.schoolId == null)
      return [];

    var registeredUnitIds = userData.registeredUnitIds!;
    var schoolDetails =
        await _schoolRepository.getSchoolDetailsFromID(userData.schoolId!);

    List<UnitDetails?> unitDetails = registeredUnitIds
        .map((unitId) => schoolDetails.units
            ?.firstWhere((unitDetails) => unitDetails.id == unitId))
        .toList();

    return unitDetails;
  }

  void saveAssignment() {
    if (formKey.currentState?.validate() ?? false) {
      _assignmentsBloc.add(AssignmentCreated(
        description: descriptionController.text,
        dueDate: state.selectedDueDate,
        title: titleController.text,
        unit: state.unit!,
      ));
    }
  }
}
