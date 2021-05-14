import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/device_query.dart';
import '../../../../cubit/manage_units/manage_units_cubit.dart';
import '../../../../cubit/navigation/navigation_cubit.dart';
import '../../../../cubit/notification/notification_cubit.dart';
import '../../../../data/repositories/school_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../common_widgets/form_view.dart';
import '../../../common_widgets/no_data_found.dart';
import 'widgets/course_dropdownformfield.dart';
import 'widgets/list_of_units.dart';
import 'widgets/school_dropdownformfield.dart';
import 'widgets/session_dropdownformfield.dart';
import 'widgets/year_dropdownformfield.dart';

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
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    ScrollController _scrollController = ScrollController();

    return FormView(
      title: "Manage Units",
      actions: [
        BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
          builder: (context, state) {
            bool enabled = (state.school != null &&
                state.course != null &&
                state.year != null &&
                state.session != null &&
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
              controller: _scrollController,
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
                Expanded(
                  child: BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
                    buildWhen: (previous, next) =>
                        previous.course != next.course,
                    builder: (context, state) {
                      return (state.course != null)
                          ? YearDropdownFormField(state)
                          : SizedBox();
                    },
                  ),
                ),
                SizedBox(height: _deviceQuery.safeHeight(3.0)),
                BlocBuilder<ManageUnitsCubit, ManageUnitsState>(
                  buildWhen: (previous, next) =>
                      previous.course != next.course ||
                      previous.session != next.session,
                  builder: (context, state) {
                    return (state.course != null)
                        ? SessionDropdownFormField(state)
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
