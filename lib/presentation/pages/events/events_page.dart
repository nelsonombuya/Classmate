import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/device_query.dart';
import '../../../data/models/event_model.dart';
import '../../../logic/bloc/events/events_bloc.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../common_widgets/no_data_found.dart';
import 'create_event.dart';
import 'event_details.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ScrollController _listViewScrollController = ScrollController();

  Color? _eventTypeColorSelector(String type) {
    switch (type) {
      case 'Personal':
        return Theme.of(context).primaryColor;
      case 'School':
        return CupertinoColors.activeOrange;
      case 'Work':
        return CupertinoColors.activeGreen;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final EventsBloc _eventsBloc = context.read<EventsBloc>();

    return StreamBuilder<List<Event>>(
      stream: _eventsBloc.personalEventsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<Event> events = snapshot.data!;
          events.sort((a, b) => a.startDate.compareTo(b.startDate));
          return ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            controller: _listViewScrollController,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(_deviceQuery.safeWidth(1.5)),
                child: FocusedMenuHolder(
                  blurSize: 5.0,
                  menuOffset: 10.0,
                  onPressed: () {},
                  menuItemExtent: 45,
                  animateMenuItems: true,
                  bottomOffsetHeight: 80.0,
                  blurBackgroundColor: Colors.black54,
                  duration: Duration(milliseconds: 100),
                  menuWidth: MediaQuery.of(context).size.width * 0.50,
                  menuBoxDecoration: BoxDecoration(
                    color: _deviceQuery.brightness == Brightness.light
                        ? CupertinoColors.systemGroupedBackground
                        : CupertinoColors.darkBackgroundGray,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                      title: Text(
                        "Edit Event Details",
                        style: TextStyle(color: CupertinoColors.activeBlue),
                      ),
                      trailingIcon: Icon(
                        Icons.edit_rounded,
                        color: CupertinoColors.activeBlue,
                      ),
                      onPressed: () => showBarModalBottomSheet(
                        context: context,
                        builder: (context) => CreateEvent(
                          event: events[index],
                          eventsBloc: _eventsBloc,
                        ),
                      ),
                    ),
                    FocusedMenuItem(
                      title: Text(
                        "Delete Event",
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                      trailingIcon: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () =>
                          context.read<NotificationCubit>().showDeleteDialog(
                                DialogType.DeleteEvent,
                                () => _eventsBloc.add(
                                  PersonalEventDeleted(
                                    events[index],
                                    popCurrentPage: false,
                                  ),
                                ),
                              ),
                    ),
                  ],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: ListTile(
                      isThreeLine: true,
                      enableFeedback: true,
                      onTap: () => showBarModalBottomSheet(
                        context: context,
                        builder: (context) => EventDetailsPage(
                          event: events[index],
                          eventsBloc: _eventsBloc,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: _deviceQuery.safeHeight(2.0),
                        horizontal: _deviceQuery.safeWidth(4.0),
                      ),
                      tileColor: _deviceQuery.brightness == Brightness.light
                          ? CupertinoColors.systemGroupedBackground
                          : CupertinoColors.darkBackgroundGray,
                      title: Text(
                        "${events[index].title}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: events[index].isAllDayEvent
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (events[index].description != null)
                                  Text("${events[index].description}"),
                                SizedBox(height: _deviceQuery.safeHeight(0.5)),
                                Text(
                                  "${events[index].eventType}",
                                  style: TextStyle(
                                    color: _eventTypeColorSelector(
                                      events[index].eventType,
                                    ),
                                  ),
                                ),
                                SizedBox(height: _deviceQuery.safeHeight(0.5)),
                                Text(
                                  "All Day: ${DateFormat('EEE dd MMM').format(events[index].startDate)}",
                                  style: TextStyle(
                                    color: events[index]
                                            .startDate
                                            .isBefore(DateTime.now())
                                        ? Theme.of(context).errorColor
                                        : null,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (events[index].description != null)
                                  Text("${events[index].description}"),
                                SizedBox(height: _deviceQuery.safeHeight(0.5)),
                                Text(
                                  "${events[index].eventType}",
                                  style: TextStyle(
                                    color: _eventTypeColorSelector(
                                      events[index].eventType,
                                    ),
                                  ),
                                ),
                                SizedBox(height: _deviceQuery.safeHeight(0.5)),
                                Text(
                                  "From: ${DateFormat('EEE dd MMM hh:mm aa').format(events[index].startDate)}",
                                  style: TextStyle(
                                    color: events[index]
                                            .startDate
                                            .isBefore(DateTime.now())
                                        ? Theme.of(context).errorColor
                                        : null,
                                  ),
                                ),
                                SizedBox(height: _deviceQuery.safeHeight(0.5)),
                                Text(
                                  "To: ${DateFormat('EEE dd MMM hh:mm aa').format(events[index].endDate)}",
                                  style: TextStyle(
                                    color: events[index]
                                            .endDate
                                            .isBefore(DateTime.now())
                                        ? Theme.of(context).errorColor
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return NoDataFound(message: "No Events Found");
      },
    );
  }
}
