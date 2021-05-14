import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/device_query.dart';
import '../../../../../cubit/manage_units/manage_units_cubit.dart';
import '../../../../../data/models/session_model.dart';
import '../../../../common_widgets/date_picker_button.dart';
import '../../../../common_widgets/no_data_found.dart';

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
        FutureBuilder<List<SessionModel>>(
          future: context.read<ManageUnitsCubit>().getListOfSessions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  DropdownButtonFormField<SessionModel>(
                    hint: Text("Select a session"),
                    value: _state.session,
                    onChanged: (SessionModel? session) {
                      if (session != null) {
                        return context
                            .read<ManageUnitsCubit>()
                            .changeSelectedSession(session);
                      }
                    },
                    items: snapshot.data!
                        .map(
                          (SessionModel session) => DropdownMenuItem(
                            value: session,
                            child: Text(session.name ?? session.id ?? "-"),
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
                          selectedDate: _state.session!.sessionStartDate ??
                              DateTime.now(),
                          overrideDateWithText:
                              _state.session!.sessionStartDate == null
                                  ? "Undefined"
                                  : null,
                        ),
                        DatePickerButton(
                          title: "Ends",
                          allDayEvent: true,
                          selectedDate:
                              _state.session!.sessionEndDate ?? DateTime.now(),
                          overrideDateWithText:
                              _state.session!.sessionEndDate == null
                                  ? "Undefined"
                                  : null,
                        ),
                      ],
                    ),
                ],
              );
            }
            return NoDataFound(
              message: "No sessions available for this school",
            );
          },
        ),
      ],
    );
  }
}
