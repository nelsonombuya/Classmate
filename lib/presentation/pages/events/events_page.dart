import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../bloc/event/event_bloc.dart';
import '../../../bloc/notification/notification_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../data/models/event_model.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final EventBloc _eventBloc = BlocProvider.of<EventBloc>(context);
    final NotificationBloc _notificationBloc =
        BlocProvider.of<NotificationBloc>(context);

    return StreamBuilder<List<EventModel>>(
      stream: _eventBloc.personalEventDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasData) {
          List<EventModel> events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceQuery.safeWidth(4.0),
                  vertical: _deviceQuery.safeHeight(1.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Slidable(
                    actionPane: SlidableBehindActionPane(),
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        icon: Icons.edit_rounded,
                        color: CupertinoColors.activeBlue,
                        onTap: () {},
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        icon: Icons.delete_rounded,
                        color: Theme.of(context).errorColor,
                        onTap: () {
                          _notificationBloc.add(
                            DeleteDialogBoxRequested(context, () {
                              _eventBloc
                                  .add(PersonalEventDeleted(events[index]));
                            }),
                          );
                        },
                      ),
                    ],
                    child: ListTile(
                      onTap: () {},
                      isThreeLine: true,
                      enableFeedback: true,
                      tileColor: CupertinoColors.systemGroupedBackground,
                      title: Text(
                        "${events[index].title}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${events[index].description}"),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "${DateFormat.jm().format(events[index].startDate)}"),
                          Text("TO"),
                          Text(
                              "${DateFormat.jm().format(events[index].endDate)}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Column(
          children: [
            Text(
              "	¯\_( ͡° ͜ʖ ͡°)_/¯",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontFamily: "Noto"),
            ),
            Text(
              "No Events Found",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontFamily: "Noto"),
            ),
          ],
        );
      },
    );
  }
}
