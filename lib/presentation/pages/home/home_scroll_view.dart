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
  final Widget child;
  final Widget leading;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0.0,
          actions: actions,
          leading: leading,
          expandedHeight: kToolbarHeight * 3.0,
          backgroundColor: Device.brightness == Brightness.light
              ? Colors.white70
              : Colors.black87,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(title, style: Theme.of(context).textTheme.headline5),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => SingleChildScrollView(
              padding: EdgeInsets.only(bottom: Device.height(8)),
              child: child,
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
