import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/course_details_model.dart';
import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';

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
        DropdownButtonFormField<CourseDetails>(
          hint: Text(_state.school!.courses!.isEmpty
              ? "No courses available for this school"
              : "Select a course to continue"),
          value: _state.course,
          onChanged: (CourseDetails? course) {
            if (course != null) {
              return context
                  .read<ManageUnitsCubit>()
                  .changeSelectedCourse(course);
            }
          },
          items: _state.school?.courses
              ?.map(
                (CourseDetails course) => DropdownMenuItem(
                  value: course,
                  child: Text(course.name ?? 'Un-named CourseDetails'),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
