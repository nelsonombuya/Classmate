import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';

class SemesterDropdownFormField extends StatelessWidget {
  const SemesterDropdownFormField(this._state, {Key? key}) : super(key: key);

  final ManageUnitsState _state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Semester",
          style: Theme.of(context).textTheme.headline6,
        ),
        DropdownButtonFormField<String>(
          hint: Text("Select a semester"),
          value: _state.semester,
          onChanged: (String? semester) {
            if (semester != null) {
              return context
                  .read<ManageUnitsCubit>()
                  .changeSelectedSemester(semester);
            }
          },
          items: context
              .read<ManageUnitsCubit>()
              .getListOfSemesters()
              ?.map(
                (String semester) => DropdownMenuItem(
                  value: semester,
                  child: Text(semester),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
