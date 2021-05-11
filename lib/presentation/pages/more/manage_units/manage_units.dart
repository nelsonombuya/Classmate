import 'package:classmate/constants/device_query.dart';
import 'package:classmate/cubit/manage_units/manage_units_cubit.dart';
import 'package:classmate/data/models/course_model.dart';
import 'package:classmate/data/models/school_model.dart';
import 'package:classmate/data/repositories/school_repository.dart';
import 'package:classmate/presentation/common_widgets/form_view.dart';
import 'package:classmate/presentation/common_widgets/no_data_found.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/course_dropdownformfield.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/school_dropdownformfield.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/year_dropdownformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageUnits extends StatelessWidget {
  final SchoolRepository _schoolRepository = SchoolRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageUnitsCubit>(
      create: (context) => ManageUnitsCubit(
        schoolRepository: _schoolRepository,
      ),
      child: _ManageUnitsView(),
    );
  }
}

class _ManageUnitsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceQuery _deviceQuery = DeviceQuery(context);

    return FormView(
      title: "Manage Units",
      child: BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              SchoolDropdownFormField(state),
              SizedBox(height: _deviceQuery.safeHeight(3.0)),
              if (state.school != null) CourseDropdownFormField(state),
              SizedBox(height: _deviceQuery.safeHeight(3.0)),
              if (state.school != null && state.course != null)
                YearDropdownFormField(state)
            ],
          );
        },
      ),
    );
  }
}
