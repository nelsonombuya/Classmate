import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/device_query.dart';
import '../../../data/models/event_model.dart';
import '../../../logic/bloc/events/events_bloc.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../common_widgets/form_view.dart';
import 'create_event.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage({required this.event, required this.eventsBloc});

  final Event event;
  final EventsBloc eventsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: eventsBloc,
      child: EventDetailsView(event),
    );
  }
}

class EventDetailsView extends StatelessWidget {
  EventDetailsView(this.event);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final EventsBloc _bloc = context.read<EventsBloc>();
    final _notificationCubit = context.read<NotificationCubit>();

    return FormView(
      title: "Event Details",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _deviceQuery.safeHeight(4.0)),
            Text(
              event.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: _deviceQuery.safeHeight(6.0)),
            Text("Date and Time"),
            event.isAllDayEvent
                ? Text(
                    "All Day: ${DateFormat('EEE dd MMM').format(event.startDate)}",
                    style: Theme.of(context).textTheme.headline5,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From: ${DateFormat('EEE dd MMM hh:mm aa').format(event.startDate)}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        "To: ${DateFormat('EEE dd MMM hh:mm aa').format(event.endDate)}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
            SizedBox(height: _deviceQuery.safeHeight(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => _notificationCubit.showDeleteDialog(
                        DialogType.DeleteEvent,
                        () => _bloc.add(PersonalEventDeleted(event)),
                      ),
                    ),
                    Text(
                      "Delete Event",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).errorColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => CreateEvent(
                            event: event,
                            eventsBloc: _bloc,
                          ),
                        );
                      },
                    ),
                    Text(
                      "Edit Event",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
