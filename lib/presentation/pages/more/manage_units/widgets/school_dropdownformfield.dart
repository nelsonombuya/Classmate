import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/school_model.dart';
import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';
import '../../../../common_widgets/no_data_found.dart';

/// ! Needs ManageUnitsCubit provided by context
class SchoolDropdownFormField extends StatelessWidget {
  const SchoolDropdownFormField(this._state, {Key? key}) : super(key: key);

  final ManageUnitsState _state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "School",
          style: Theme.of(context).textTheme.headline6,
        ),
        FutureBuilder<List<SchoolModel>>(
          future: context.read<ManageUnitsCubit>().getListOfSchools(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            }
            if (snapshot.hasData) {
              return DropdownButtonFormField(
                value: _state.school,
                hint: Text("Select a school to continue"),
                onChanged: (SchoolModel? school) {
                  if (school != null) {
                    return context
                        .read<ManageUnitsCubit>()
                        .changeSelectedSchool(school);
                  }
                },
                items: snapshot.data!
                    .map((SchoolModel school) => DropdownMenuItem(
                          value: school,
                          child: Text(school.name),
                        ))
                    .toList(),
              );
            }
            return NoDataFound(message: "No schools available in the database");
          },
        ),
      ],
    );
  }
}
