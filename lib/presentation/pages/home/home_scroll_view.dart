import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device_query.dart';

class HomeScrollView extends StatelessWidget {
  final PageView child;
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  HomeScrollView({
    this.title,
    this.actions,
    this.leading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            elevation: 0.0,
            actions: actions,
            leading: leading,
            expandedHeight: kToolbarHeight * 3.0,
            backgroundColor: _deviceQuery.brightness == Brightness.light
                ? CupertinoColors.systemGroupedBackground
                : CupertinoColors.darkBackgroundGray,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding:
                  EdgeInsets.only(bottom: _deviceQuery.safeHeight(1.6)),
              title: (title == null)
                  ? null
                  : Text(title!, style: Theme.of(context).textTheme.headline5),
            ),
          ),
        ];
      },
      body: child,
    );
  }
}
