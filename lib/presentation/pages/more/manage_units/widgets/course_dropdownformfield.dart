import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/course_model.dart';
import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';
import '../../../../common_widgets/no_data_found.dart';

class CourseDropdownFormField extends StatelessWidget {
  const CourseDropdownFormField(this._state, {Key? key}) : super(key: key);

  final ManageUnitsState _state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Course",
          style: Theme.of(context).textTheme.headline6,
        ),
        FutureBuilder<List<CourseModel>>(
          future: context.read<ManageUnitsCubit>().getListOfCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return DropdownButtonFormField(
                hint: Text("Select a course to continue"),
                value: _state.course,
                onChanged: (CourseModel? course) {
                  if (course != null) {
                    return context
                        .read<ManageUnitsCubit>()
                        .changeSelectedCourse(course);
                  }
                },
                items: snapshot.data!
                    .map(
                      (CourseModel course) => DropdownMenuItem(
                        value: course,
                        child: Text(course.name),
                      ),
                    )
                    .toList(),
              );
            }
            return NoDataFound(
              message: "No courses available for this school",
            );
          },
        ),
      ],
    );
  }
}
