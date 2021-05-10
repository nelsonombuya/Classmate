import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/device_query.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({String? title, List<Widget>? actions})
      : _title = title,
        _actions = actions;

  final String? _title;
  final List<Widget>? _actions;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      actions: _actions,
      expandedHeight: kToolbarHeight * 3.0,
      iconTheme: IconThemeData(
        color: _deviceQuery.brightness == Brightness.light
            ? CupertinoColors.black
            : CupertinoColors.systemGrey4,
      ),
      backgroundColor: _deviceQuery.brightness == Brightness.light
          ? CupertinoColors.systemGroupedBackground.withOpacity(0.7)
          : CupertinoColors.darkBackgroundGray.withOpacity(0.8),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(
          bottom: _deviceQuery.safeHeight(1.6),
        ),
        title: (_title == null)
            ? null
            : Text(
                _title!.toUpperCase(),
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
