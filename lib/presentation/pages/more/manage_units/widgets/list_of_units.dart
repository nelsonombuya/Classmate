import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/device_query.dart';
import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';

class ListOfUnits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final listOfUnits = context.read<ManageUnitsCubit>().getListOfUnits();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Units",
          style: Theme.of(context).textTheme.headline6,
        ),
        Divider(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listOfUnits.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: _deviceQuery.safeHeight(0.4)),
                Text(
                  "${listOfUnits[index]?.codes}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: _deviceQuery.safeHeight(2.4)),
                ),
                Text(
                  "\u2022 ${listOfUnits[index]?.name}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: _deviceQuery.safeHeight(2.4)),
                ),
                SizedBox(height: _deviceQuery.safeHeight(1.6)),
              ],
            );
          },
        ),
        Divider(),
      ],
    );
  }
}
