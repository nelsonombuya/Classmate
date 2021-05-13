import 'package:classmate/constants/device_query.dart';
import 'package:classmate/cubit/manage_units/manage_units_cubit.dart';
import 'package:classmate/cubit/navigation/navigation_cubit.dart';
import 'package:classmate/cubit/notification/notification_cubit.dart';
import 'package:classmate/data/models/course_model.dart';
import 'package:classmate/data/models/school_model.dart';
import 'package:classmate/data/repositories/school_repository.dart';
import 'package:classmate/data/repositories/user_repository.dart';
import 'package:classmate/presentation/common_widgets/form_view.dart';
import 'package:classmate/presentation/common_widgets/no_data_found.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/course_dropdownformfield.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/school_dropdownformfield.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/list_of_units.dart';
import 'package:classmate/presentation/pages/more/manage_units/widgets/year_dropdownformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageUnits extends StatelessWidget {
  final SchoolRepository _schoolRepository = SchoolRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageUnitsCubit>(
      create: (context) => ManageUnitsCubit(
        schoolRepository: _schoolRepository,
        userRepository: context.read<UserRepository>(),
        navigationCubit: context.read<NavigationCubit>(),
        notificationCubit: context.read<NotificationCubit>(),
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
      actions: [
        BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
          builder: (context, state) {
            bool enabled = (state.school != null &&
                state.course != null &&
                state.year != null &&
                state.changed == true);
            return TextButton(
              onPressed: enabled
                  ? () => context
                      .read<ManageUnitsCubit>()
                      .saveCourseDetailsToDatabase()
                  : null,
              child: Text(
                "SAVE",
                textScaleFactor: 1.2,
              ),
            );
          },
        ),
      ],
      child: FutureBuilder(
        future: context.read<ManageUnitsCubit>().checkUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              shrinkWrap: true,
              children: [
                BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
                  buildWhen: (previous, next) => previous.school != next.school,
                  builder: (context, state) {
                    return SchoolDropdownFormField(state);
                  },
                ),
                SizedBox(height: _deviceQuery.safeHeight(3.0)),
                BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
                  buildWhen: (previous, next) => previous.school != next.school,
                  builder: (context, state) {
                    return (state.school != null)
                        ? CourseDropdownFormField(state)
                        : SizedBox();
                  },
                ),
                SizedBox(height: _deviceQuery.safeHeight(3.0)),
                BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
                  buildWhen: (previous, next) => previous.course != next.course,
                  builder: (context, state) {
                    return (state.course != null)
                        ? YearDropdownFormField(state)
                        : SizedBox();
                  },
                ),
                SizedBox(height: _deviceQuery.safeHeight(3.0)),
                BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
                  buildWhen: (previous, next) => previous.year != next.year,
                  builder: (context, state) {
                    return (state.year != null) ? ListOfUnits() : SizedBox();
                  },
                ),
              ],
            );
          }
          return NoDataFound(message: "Error Fetching Data");
        },
      ),
    );
  }
}
