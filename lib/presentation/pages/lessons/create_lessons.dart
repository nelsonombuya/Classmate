import 'package:classmate/data/models/assignment_model.dart';
import 'package:classmate/data/models/lesson_model.dart';
import 'package:classmate/data/models/unit_model.dart';
import 'package:classmate/logic/bloc/lessons/lessons_bloc.dart';
import 'package:classmate/logic/cubit/create_lesson/create_lesson_cubit.dart';

import '../../../constants/device_query.dart';
import '../../../data/models/unit_details_model.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../logic/bloc/assignments/assignments_bloc.dart';
import '../../../logic/cubit/create_lesson/create_lesson_cubit.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/date_picker_button.dart';
import '../../common_widgets/form_view.dart';
import '../../common_widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateLessonForm extends StatelessWidget {
  const CreateLessonForm({
    required SchoolRepository schoolRepository,
    required UserRepository userRepository,
    required LessonsBloc lessonsBloc,
    Lesson? lesson,
    Unit? unit,
    int? index,
  })  : _schoolRepository = schoolRepository,
        _userRepository = userRepository,
        _lessonsBloc = lessonsBloc,
        _lesson = lesson,
        _unit = unit,
        _index = index;

  final int? _index;
  final Lesson? _lesson;
  final LessonsBloc _lessonsBloc;
  final SchoolRepository _schoolRepository;
  final Unit? _unit;
  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateLessonCubit>(
      create: (context) => CreateLessonCubit(
        schoolRepository: _schoolRepository,
        userRepository: _userRepository,
        lessonsBloc: _lessonsBloc,
      ),
      child: CreateLessonFormView(_unit, _lesson, _index),
    );
  }
}

class CreateLessonFormView extends StatefulWidget {
  CreateLessonFormView(this._unit, this._lesson, this._index);

  final int? _index;
  final Lesson? _lesson;
  final Unit? _unit;

  @override
  _CreateLessonFormViewState createState() => _CreateLessonFormViewState();
}

class _CreateLessonFormViewState extends State<CreateLessonFormView> {
  @override
  void initState() {
    super.initState();
    if (widget._lesson != null &&
        widget._unit != null &&
        widget._index != null) {
      context
          .read<CreateLessonCubit>()
          .setLessonDetails(widget._lesson!, widget._unit!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deviceQuery = DeviceQuery(context);
    final _cubit = context.watch<CreateLessonCubit>();

    return FormView(
      title: "New Lesson",
      actions: [
        TextButton(
          onPressed: _cubit.state.unit == null
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  widget._unit != null && widget._lesson != null
                      ? _cubit.updateLesson(
                          widget._unit!,
                          widget._lesson!,
                          widget._index!,
                        )
                      : _cubit.saveLesson();
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
              label: 'Title',
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
            if (widget._lesson == null)
              Row(
                children: [
                  SizedBox(width: _deviceQuery.safeWidth(2.0)),
                  Text(
                    "Set time for all lessons",
                    style: TextStyle(
                      fontSize: _deviceQuery.safeHeight(2.1),
                      fontWeight: _cubit.state.setForAllLessons
                          ? FontWeight.bold
                          : null,
                    ),
                  ),
                  Switch.adaptive(
                    value: _cubit.state.setForAllLessons,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) => _cubit.changeSetForAllLessons(value),
                  ),
                ],
              ),
            if (_cubit.state.setForAllLessons)
              Text(
                "Please select the date and time the first class for this unit begins and ends.",
              ),
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePickerButton(
                  title: "Start Date",
                  selectedDate: _cubit.state.selectedStartDate,
                  onTap: (DateTime date) =>
                      _cubit.changeSelectedStartDate(date),
                ),
                DatePickerButton(
                  title: "End Date",
                  selectedDate: _cubit.state.selectedEndDate,
                  onTap: (DateTime date) => _cubit.changeSelectedEndDate(date),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
