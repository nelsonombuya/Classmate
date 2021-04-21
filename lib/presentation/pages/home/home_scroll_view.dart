import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class HomeScrollView extends StatelessWidget {
  HomeScrollView({
    @required this.currentIndex,
    @required this.labels,
    @required this.pages,
    this.actions,
  });

  final List<Widget> actions;
  final List<String> labels;
  final List<Widget> pages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0.0,
          actions: actions,
          centerTitle: true,
          expandedHeight: kToolbarHeight * 2.0,
          backgroundColor: Device.brightness == Brightness.light
              ? Colors.white70
              : Colors.black87,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              labels[currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontFamily: "Averta"),
            ),
          ),
        ),
        SliverFillRemaining(child: pages[currentIndex]),
      ],
    );
  }
}
