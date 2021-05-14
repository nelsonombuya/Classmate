import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/manage_units/manage_units_cubit.dart';
import '../../../../../data/models/session_model.dart';
import '../../../../common_widgets/no_data_found.dart';

class SessionDropdownFormField extends StatelessWidget {
  const SessionDropdownFormField(this._state, {Key? key}) : super(key: key);

  final ManageUnitsState _state;

  @override
  Widget build(BuildContext context) {
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
              return DropdownButtonFormField<SessionModel>(
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
