import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../bloc/events/events_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../cubit/notification/notification_cubit.dart';
import '../../../data/models/event_model.dart';
import '../../common_widgets/no_data_found.dart';
import 'create_event.dart';
import 'event_details.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ScrollController _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final EventsBloc _eventsBloc = context.read<EventsBloc>();

    return StreamBuilder<List<EventModel>>(
      stream: context.read<EventsBloc>().personalEventDataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<EventModel> events = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            controller: _listViewScrollController,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(
                  _deviceQuery.safeWidth(4.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableBehindActionPane(),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        icon: Icons.edit_rounded,
                        color: CupertinoColors.activeBlue,
                        onTap: () => showBarModalBottomSheet(
                          context: context,
                          builder: (context) => CreateEvent(
                            event: events[index],
                            eventsBloc: _eventsBloc,
                          ),
                        ),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        icon: Icons.delete_rounded,
                        color: Theme.of(context).errorColor,
                        onTap: () =>
                            context.read<NotificationCubit>().showDeleteDialog(
                                  DialogType.DeleteEvent,
                                  // * If the dialog is accepted
                                  // * It will send an event deleted request
                                  () => _eventsBloc.add(
                                    PersonalEventDeleted(
                                      events[index],
                                      popCurrentPage: false,
                                    ),
                                  ),
                                ),
                      ),
                    ],
                    child: ListTile(
                      isThreeLine: true,
                      enableFeedback: true,
                      onTap: () => showBarModalBottomSheet(
                        context: context,
                        builder: (context) => EventDetailsPage(
                          event: events[index],
                          eventsBloc: context.read<EventsBloc>(),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: _deviceQuery.safeWidth(4.0),
                        vertical: _deviceQuery.safeHeight(2.0),
                      ),
                      tileColor: _deviceQuery.brightness == Brightness.light
                          ? CupertinoColors.systemGroupedBackground
                          : CupertinoColors.darkBackgroundGray,
                      leading: Icon(
                        Icons.person_rounded,
                        color: CupertinoColors.activeBlue,
                      ),
                      title: Text(
                        "${events[index].title}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: events[index].isAllDayEvent
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${events[index].description}"),
                                SizedBox(height: _deviceQuery.safeHeight(2.0)),
                                Text(
                                    "All Day: ${DateFormat('EEE dd MMM').format(events[index].startDate)}"),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${events[index].description}"),
                                SizedBox(height: _deviceQuery.safeHeight(2.0)),
                                Text(
                                    "From: ${DateFormat('EEE dd MMM hh:mm aa').format(events[index].startDate)}"),
                                SizedBox(height: _deviceQuery.safeHeight(1.0)),
                                Text(
                                    "To: ${DateFormat('EEE dd MMM hh:mm aa').format(events[index].endDate)}"),
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
