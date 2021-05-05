import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_query.dart';
import '../../../cubit/manage_course/manage_course_cubit.dart';
import '../../../data/repositories/unit_repository.dart';
import '../../common_widgets/custom_elevated_button.dart';
import '../../common_widgets/form_view.dart';
import '../../common_widgets/no_data_found.dart';

class ManageCourseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DeviceQuery(
      context,
      BlocProvider<ManageCourseCubit>(
        create: (context) => ManageCourseCubit(context),
        child: ManageCoursesFormView(),
      ),
    );
  }
}

class ManageCoursesFormView extends StatefulWidget {
  @override
  _ManageCoursesFormViewState createState() => _ManageCoursesFormViewState();
}

class _ManageCoursesFormViewState extends State<ManageCoursesFormView> {
  @override
  Widget build(BuildContext context) {
    final ManageCourseCubit _manageCourseCubit =
        BlocProvider.of<ManageCourseCubit>(context);
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    bool _addOtherUnits = false;

    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: StreamBuilder<QuerySnapshot>(
            stream: _manageCourseCubit.coursesDataStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              }

              if (snapshot.hasData) {
                var courses = [];
                snapshot.data.docs.forEach((doc) => courses.add(doc.id));

                return FormView(
                  title: "Course Details",
                  child: Column(
                    children: [
                      SizedBox(height: _deviceQuery.safeHeight(2.0)),
                      Text("Please Select Your Course"),
                      SizedBox(height: _deviceQuery.safeHeight(1.0)),
                      BlocBuilder<ManageCourseCubit, ManageCourseState>(
                        builder: (context, state) {
                          return DropdownButtonFormField<String>(
                            value: state.courseId,
                            items: courses.map((courseId) {
                              return DropdownMenuItem<String>(
                                child: Text(courseId),
                                value: courseId,
                              );
                            }).toList(),
                            onChanged: (String? courseID) {
                              _manageCourseCubit.changeSelectedCourse(courseID);
                            },
                          );
                        },
                      ),
                      SizedBox(height: _deviceQuery.safeHeight(6.0)),
                      BlocBuilder<ManageCourseCubit, ManageCourseState>(
                        builder: (context, state) {
                          if (state.courseId != null) {
                            var years = [];
                            var selectedCourseIndex =
                                courses.indexOf(state.courseId);
                            years = (snapshot.data.docs[selectedCourseIndex]
                                        .data()['units'] ==
                                    null)
                                ? []
                                : snapshot.data.docs[selectedCourseIndex]
                                    .data()['units']
                                    .keys
                                    .toList();

                            var _yearString = (year) {
                              switch (year) {
                                case 'year_1':
                                  return 'Year 1';
                                case 'year_2':
                                  return 'Year 2';
                                case 'year_3':
                                  return 'Year 3';
                                case 'year_4':
                                  return 'Year 4';
                                default:
                                  throw Exception('Invalid year given');
                              }
                            };
                            return Column(
                              children: [
                                Text("Please select your year"),
                                SizedBox(height: _deviceQuery.safeHeight(1.0)),
                                DropdownButtonFormField<String>(
                                  value: state.year,
                                  items: years.map((year) {
                                    return DropdownMenuItem<String>(
                                      child: Text(_yearString(year)),
                                      value: year,
                                    );
                                  }).toList(),
                                  onChanged: (String? year) {
                                    _manageCourseCubit.changeSelectedYear(year);
                                  },
                                )
                              ],
                            );
                          }
                          return Text("Please select a course to continue");
                        },
                      ),
                      SizedBox(height: _deviceQuery.safeHeight(6.0)),
                      BlocConsumer<ManageCourseCubit, ManageCourseState>(
                        listener: (context, state) {
                          if (state is CourseDetailsUpdatedSuccessfully) {
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          if (state.courseId != null && state.year != null) {
                            var selectedCourseIndex =
                                courses.indexOf(state.courseId);
                            var selectedYear = state.year;
                            var units = snapshot.data.docs[selectedCourseIndex]
                                .data()['units'][selectedYear];

                            List<DocumentReference> unitReferences = [];
                            units.forEach(
                                (unit) => unitReferences.add(unit['ref']));

                            return Column(
                              children: [
                                Text("Confirm your units"),
                                SizedBox(height: _deviceQuery.safeHeight(1.0)),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: units.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\u2022 ${units[index]['name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: _deviceQuery.safeHeight(4.0)),
                                CustomElevatedButton(
                                  label: "CONFIRM",
                                  onPressed: () {
                                    _manageCourseCubit
                                        .addSelectedUnits(unitReferences);
                                    _manageCourseCubit.saveCourseDetails();
                                  },
                                ),
                              ],
                            );
                          }
                          if (state.courseId == null && state.year == null) {
                            return SizedBox();
                          }
                          return Text("Please select a year to continue");
                        },
                      ),
                    ],
                  ),
                );
              }
              return NoDataFound(message: "No Courses Found");
            },
          ),
        ),
        TextButton(
          child: Text("Add Other Units"),
          onPressed: () => setState(() => _addOtherUnits = !_addOtherUnits),
        ),
        if (_addOtherUnits)
          BlocBuilder<ManageCourseCubit, ManageCourseState>(
            builder: (context, state) {
              UnitRepository _unitRepository = UnitRepository();
              ScrollController _scrollController = ScrollController();

              return StreamBuilder(
                stream: _unitRepository.unitsStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator.adaptive();
                  }

                  if (snapshot.hasError) {
                    return Text("Error gathering data");
                  }

                  if (snapshot.hasData) {
                    var units = snapshot.data.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          value: state.selectedUnits
                                  ?.indexOf(units[index].data()['ref']) ==
                              -1,
                          title: Text(units[index].data()['name']),
                          onChanged: (value) {
                            value == true
                                ? _manageCourseCubit.addSelectedUnits(
                                    units[index].data()['ref'])
                                : _manageCourseCubit.removeSelectedUnits(
                                    units[index].data()['ref']);
                          },
                        );
                      },
                    );
                  }
                  return Text("No Data Found");
                },
              );
            },
          ),
      ],
    );
  }
}
