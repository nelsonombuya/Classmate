import '../../../constants/device_query.dart';
import '../../../data/models/unit_details_model.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../logic/bloc/assignments/assignments_bloc.dart';
import '../../../logic/cubit/create_assignment/create_assignment_cubit.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/date_picker_button.dart';
import '../../common_widgets/form_view.dart';
import '../../common_widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAssignmentForm extends StatelessWidget {
  const CreateAssignmentForm({
    required SchoolRepository schoolRepository,
    required AssignmentsBloc assignmentsBloc,
    required UserRepository userRepository,
  })  : _assignmentsBloc = assignmentsBloc,
        _schoolRepository = schoolRepository,
        _userRepository = userRepository;

  final SchoolRepository _schoolRepository;
  final AssignmentsBloc _assignmentsBloc;
  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateAssignmentCubit>(
      create: (context) => CreateAssignmentCubit(
        schoolRepository: _schoolRepository,
        assignmentsBloc: _assignmentsBloc,
        userRepository: _userRepository,
      ),
      child: CreateAssignmentFormView(),
    );
  }
}

class CreateAssignmentFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _deviceQuery = DeviceQuery(context);
    final _cubit = context.watch<CreateAssignmentCubit>();

    return FormView(
      title: "New Assignment",
      actions: [
        TextButton(
          onPressed: _cubit.state.unit == null
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  _cubit.saveAssignment();
                },
          child: Text(
            "SAVE",
            textScaleFactor: 1.2,
          ),
        ),
      ],
      child: Form(
        key: _cubit.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
            CustomTextFormField(
              size: 2.8,
              label: 'Assignment',
              validator: _cubit.titleValidator,
              keyboardType: TextInputType.text,
              controller: _cubit.titleController,
            ),
            SizedBox(height: _deviceQuery.safeHeight(3.0)),
            FutureBuilder<List<UnitDetails?>>(
                future: _cubit.getRegisteredUnits(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }

                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return DropdownButtonFormField(
                      validator: (unit) =>
                          unit != null ? null : "Kindly select a unit",
                      value: _cubit.state.unit,
                      hint: Text("Select a unit"),
                      onChanged: (UnitDetails? unit) {
                        return (unit == null)
                            ? null
                            : _cubit.changeSelectedUnit(unit);
                      },
                      items: snapshot.data!
                          .map((UnitDetails? unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit?.name ?? 'Unnamed Unit'),
                              ))
                          .toList(),
                    );
                  }

                  return NoDataFound(
                    message: "No Registered Units",
                  );
                }),
            SizedBox(height: _deviceQuery.safeHeight(3.0)),
            CustomTextFormField(
              maxLines: null,
              label: 'Description',
              keyboardType: TextInputType.text,
              controller: _cubit.descriptionController,
            ),
            SizedBox(height: _deviceQuery.safeHeight(3.0)),
            DatePickerButton(
              title: "Due Date",
              selectedDate: _cubit.state.selectedDueDate,
              onTap: (DateTime dueDate) => _cubit.changeSelectedDate(dueDate),
            ),
          ],
        ),
      ),
    );
  }
}
