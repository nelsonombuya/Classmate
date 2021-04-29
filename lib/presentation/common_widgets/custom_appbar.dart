import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  late final DeviceQuery _deviceQuery;

  CustomAppBar({this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);

    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      actions: actions,
      expandedHeight: kToolbarHeight * 3.0,
      // TODO Find a way to standardize colors using Theme ✨
      iconTheme: IconThemeData(
        color: _deviceQuery.brightness == Brightness.light
            ? CupertinoColors.black
            : CupertinoColors.systemGrey4,
      ),
      // TODO Find a way to standardize colors using Theme ✨
      backgroundColor: _deviceQuery.brightness == Brightness.light
          ? CupertinoColors.systemGroupedBackground
          : CupertinoColors.darkBackgroundGray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: _deviceQuery.safeHeight(1.6)),
        title: (title == null)
            ? null
            : Text(
                title!.toUpperCase(),
                style: (Theme.of(context).textTheme.headline5 == null)
                    ? null
                    : Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
