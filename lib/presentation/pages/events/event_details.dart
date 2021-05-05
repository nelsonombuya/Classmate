import 'package:classmate/bloc/event/event_bloc.dart';
import 'package:classmate/bloc/notification/notification_bloc.dart';
import 'package:classmate/constants/device_query.dart';
import 'package:classmate/data/models/event_model.dart';
import 'package:classmate/presentation/common_widgets/form_view.dart';
import 'package:classmate/presentation/pages/home/forms/create_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage(this.event);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBloc>(
      create: (context) => EventBloc(context),
      child: EventDetailsView(this.event),
    );
  }
}

class EventDetailsView extends StatelessWidget {
  final EventModel event;

  const EventDetailsView(this.event);

  @override
  Widget build(BuildContext context) {
    EventBloc _eventBloc = BlocProvider.of<EventBloc>(context);
    NotificationBloc _notificationBloc =
        BlocProvider.of<NotificationBloc>(context);

    return BlocListener<EventBloc, EventState>(
      listener: (context, state) {
        if (state is EventDeletedSuccessfully ||
            state is EventUpdatedSuccessfully) {
          Navigator.of(context).pop();
        }
      },
      child: DeviceQuery(
        context,
        FormView(
          title: "Event Details",
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 40),
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
                SizedBox(height: 100),
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
                          onPressed: () {
                            _notificationBloc.add(
                              DeleteDialogBoxRequested(
                                context,
                                () => _eventBloc.add(
                                  PersonalEventDeleted(event),
                                ),
                              ),
                            );
                          },
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
                              builder: (context) => CreateEvent(event: event),
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
        ),
      ),
    );
  }
}
