import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_query.dart';
import '../../../cubit/manage_course/manage_course_cubit.dart';
import '../../../data/repositories/unit_repository.dart';
import '../../common_widgets/form_view.dart';

class AddAnotherUnit extends StatelessWidget {
  final UnitRepository _unitRepository;
  final ManageCourseCubit _manageCourseCubit;

  AddAnotherUnit(this._manageCourseCubit) : _unitRepository = UnitRepository();

  @override
  Widget build(BuildContext context) {
    return DeviceQuery(
      context,
      FormView(
        title: "Add Units",
        child: BlocProvider(
          create: (context) => ManageCourseCubit(context),
          child: StreamBuilder(
            stream: _unitRepository.unitsStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              }

              if (snapshot.hasError) {
                return Text("Error gathering data");
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BlocBuilder<ManageCourseCubit, ManageCourseState>(
                      builder: (context, state) {
                        return CheckboxListTile(
                          value: state.selectedUnits!.indexOf(
                                  snapshot.data.docs[index].data()['ref']) ==
                              -1,
                          title: Text(snapshot.data.docs[index].data()['name']),
                          onChanged: (value) {
                            value == true
                                ? _manageCourseCubit.addSelectedUnits(
                                    snapshot.data.docs[index].data()['ref'])
                                : _manageCourseCubit.removeSelectedUnits(
                                    snapshot.data.docs[index].data()['ref']);
                          },
                        );
                      },
                    );
                  },
                );
              }

              return Text("No Data Found");
            },
          ),
        ),
      ),
    );
  }
}
