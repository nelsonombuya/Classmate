import 'package:classmate/presentation/pages/events/event_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../bloc/event/event_bloc.dart';
import '../../../bloc/notification/notification_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../data/models/event_model.dart';
import '../../common_widgets/no_data_found.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ScrollController _listViewScrollController = ScrollController();
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
            shrinkWrap: true,
            itemCount: events.length,
            controller: _listViewScrollController,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                            DeleteDialogBoxRequested(
                              context,
                              () => _eventBloc.add(
                                PersonalEventDeleted(events[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    child: ListTile(
                      onTap: () => showBarModalBottomSheet(
                        context: context,
                        builder: (context) => EventDetailsPage(events[index]),
                      ),
                      isThreeLine: true,
                      enableFeedback: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                    "All Day On: ${DateFormat('EEE dd MMM').format(events[index].startDate)}"),
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
