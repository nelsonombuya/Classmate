import 'manage_units/manage_units.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MorePage extends StatelessWidget {
  final ScrollController _listViewScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        controller: _listViewScrollController,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: ListTile(
              enableFeedback: true,
              title: Text(
                "Manage Registered Units",
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: Icon(Icons.school_rounded),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tileColor:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? CupertinoColors.systemGroupedBackground
                      : CupertinoColors.darkBackgroundGray,
              onTap: () => showBarModalBottomSheet(
                context: context,
                builder: (context) => ManageUnits(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
