import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';

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
        DropdownButtonFormField<String>(
          hint: Text("Select a year"),
          value: _state.year,
          onChanged: (String? year) {
            if (year != null) {
              return context.read<ManageUnitsCubit>().changeSelectedYear(year);
            }
          },
          items: context
              .read<ManageUnitsCubit>()
              .getListOfYears()
              ?.map(
                (String year) => DropdownMenuItem(
                  value: year,
                  child: Text(year),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
