import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/device_query.dart';
import '../../../../../data/models/session_details_model.dart';
import '../../../../../logic/cubit/manage_units/manage_units_cubit.dart';
import '../../../../common_widgets/date_picker_button.dart';

class SessionDropdownFormField extends StatelessWidget {
  const SessionDropdownFormField(this._state, {Key? key}) : super(key: key);

  final ManageUnitsState _state;

  @override
  Widget build(BuildContext context) {
    DeviceQuery _deviceQuery = DeviceQuery(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Session",
          style: Theme.of(context).textTheme.headline6,
        ),
        Column(
          children: [
            DropdownButtonFormField<SessionDetails>(
              hint: Text("Select a session"),
              value: _state.session,
              onChanged: (SessionDetails? session) {
                if (session != null) {
                  return context
                      .read<ManageUnitsCubit>()
                      .changeSelectedSession(session);
                }
              },
              items: context
                  .read<ManageUnitsCubit>()
                  .getListOfSessions()
                  ?.map(
                    (SessionDetails session) => DropdownMenuItem(
                      value: session,
                      child: Text(session.name ?? "Unnamed Session"),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
            if (_state.session != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DatePickerButton(
                    title: "Starts",
                    allDayEvent: true,
                    selectedDate: _state.session!.startDate ?? DateTime.now(),
                    overrideDateWithText:
                        _state.session!.startDate == null ? "Undefined" : null,
                  ),
                  DatePickerButton(
                    title: "Ends",
                    allDayEvent: true,
                    selectedDate: _state.session!.endDate ?? DateTime.now(),
                    overrideDateWithText:
                        _state.session!.endDate == null ? "Undefined" : null,
                  ),
                ],
              ),
          ],
        )
      ],
    );
  }
}
