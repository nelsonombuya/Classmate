import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';

import '../../../bloc/event/event_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../data/models/event_model.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // DateTime _selectedDay = DateTime.now(), _focusedDay = DateTime.now();
  // DateTime _firstDay = DateTime(DateTime.now().year - 20);
  // DateTime _lastDay = DateTime(DateTime.now().year + 20);
  // CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final EventBloc _eventBloc = BlocProvider.of<EventBloc>(context);

    return StreamBuilder<List<EventModel>>(
      stream: _eventBloc.eventDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceQuery.safeWidth(4.0),
                vertical: _deviceQuery.safeHeight(1.0),
              ),
              child: FocusedMenuHolder(
                blurSize: 0.0,
                menuOffset: 10.0,
                menuItemExtent: 45,
                animateMenuItems: true,
                bottomOffsetHeight: 80.0,
                blurBackgroundColor: Colors.black54,
                duration: Duration(milliseconds: 100),
                menuWidth: MediaQuery.of(context).size.width * 0.50,
                menuBoxDecoration: BoxDecoration(
                  color: CupertinoColors.systemGroupedBackground,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                menuItems: <FocusedMenuItem>[
                  FocusedMenuItem(
                    title: Text("Details"),
                    trailingIcon: Icon(Icons.open_in_new_rounded),
                    onPressed: () {},
                  ),
                  FocusedMenuItem(
                    title: Text("Edit"),
                    trailingIcon: Icon(Icons.edit_rounded),
                    onPressed: () {},
                  ),
                  FocusedMenuItem(
                    title: Text(
                      "Delete",
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    trailingIcon: Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () {},
                  ),
                ],
                onPressed: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ListTile(
                    onTap: () {},
                    isThreeLine: true,
                    enableFeedback: true,
                    tileColor: CupertinoColors.systemGroupedBackground,
                    title: Text(
                      "${snapshot.data![index].title}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${snapshot.data![index].description}"),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "${DateFormat.jm().format(snapshot.data![index].startingDate)}"),
                        Text("TO"),
                        Text(
                            "${DateFormat.jm().format(snapshot.data![index].endingDate)}"),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    // return ListView(
    //   children: <Widget>[
    //     Container(
    //       color: _deviceQuery.brightness == Brightness.light
    //           ? CupertinoColors.systemGroupedBackground
    //           : CupertinoColors.darkBackgroundGray,
    //       child: TableCalendar(
    //         lastDay: _lastDay,
    //         firstDay: _firstDay,
    //         focusedDay: _focusedDay,
    //         calendarFormat: _calendarFormat,
    //         selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
    //         onDaySelected: (selectedDay, focusedDay) {
    //           setState(
    //             () {
    //               _selectedDay = selectedDay;
    //               _focusedDay = focusedDay;
    //             },
    //           );
    //         },
    //         onFormatChanged: (format) {
    //           setState(
    //             () {
    //               _calendarFormat = format;
    //             },
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
