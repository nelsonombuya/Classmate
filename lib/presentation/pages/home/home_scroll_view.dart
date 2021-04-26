import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class HomeScrollView extends StatelessWidget {
  HomeScrollView({
    this.title,
    this.child,
    this.actions,
    this.leading,
  });

  final String title;
  final Widget leading;
  final PageView child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            elevation: 0.0,
            actions: actions,
            leading: leading,
            expandedHeight: kToolbarHeight * 3.0,
            backgroundColor: Device.brightness == Brightness.light
                ? CupertinoColors.systemGroupedBackground
                : CupertinoColors.darkBackgroundGray,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: Device.height(1.6)),
              title: Text(title, style: Theme.of(context).textTheme.headline5),
            ),
          ),
        ];
      },
      body: child,
    );
  }
}
