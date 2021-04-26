import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/device.dart';
import 'add_event_form.dart';

/// # Custom Floating Action Button
/// Allows the user to view the following forms:
///   - Add New Event
///   - Add New Task
/// ! Depends on Speed Dial Package
class CustomFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Device().init(context);

    Color _fabColor = Device.brightness == Brightness.light
        ? CupertinoColors.systemGroupedBackground
        : CupertinoColors.darkBackgroundGray;

    return SpeedDial(
      tooltip: "Add Items",
      backgroundColor: _fabColor,
      curve: Curves.fastLinearToSlowEaseIn,
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          label: "Add Event",
          child: Icon(Icons.event),
          backgroundColor: _fabColor,
          labelBackgroundColor: _fabColor,
          onTap: () => showBarModalBottomSheet(
            context: context,
            builder: (context) => Container(child: AddEventForm()),
          ),
        ),
        SpeedDialChild(
          label: "Add Task",
          backgroundColor: _fabColor,
          labelBackgroundColor: _fabColor,
          child: Icon(
            Icons.check_circle_outline_rounded,
          ),
        ),
      ],
    );
  }
}
