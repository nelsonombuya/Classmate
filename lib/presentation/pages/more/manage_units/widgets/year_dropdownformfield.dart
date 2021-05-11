import 'package:classmate/cubit/manage_units/manage_units_cubit.dart';
import 'package:classmate/data/models/course_model.dart';
import 'package:classmate/presentation/common_widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YearDropdownFormField extends StatelessWidget {
  const YearDropdownFormField(this._state, {Key? key}) : super(key: key);

  final ManageUnitsState _state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Year",
          style: Theme.of(context).textTheme.headline6,
        ),
        FutureBuilder<List<String>>(
          future: context.read<ManageUnitsCubit>().getListOfYears(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            }
            if (snapshot.hasData) {
              return DropdownButtonFormField<String>(
                hint: Text("Select a year to continue"),
                value: _state.year,
                onChanged: (String? year) {
                  if (year != null) {
                    return context
                        .read<ManageUnitsCubit>()
                        .changeSelectedYear(year);
                  }
                },
                items: snapshot.data!
                    .map(
                      (String year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
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
