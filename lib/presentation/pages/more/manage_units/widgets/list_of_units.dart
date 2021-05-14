import '../../../../../constants/device_query.dart';
import '../../../../../cubit/manage_units/manage_units_cubit.dart';
import '../../../../common_widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfUnits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return FutureBuilder<List>(
      future: context.read<ManageUnitsCubit>().getListOfUnits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: _deviceQuery.safeHeight(0.4)),
                      Text(
                        "${snapshot.data![index]['code']}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: _deviceQuery.safeHeight(2.4)),
                      ),
                      Text(
                        "\u2022 ${snapshot.data![index]['name']}",
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
            ],
          );
        }
        return NoDataFound(message: "No units found");
      },
    );
  }
}
