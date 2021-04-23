import 'package:flutter/material.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

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
    TextStyle _titleStyle = Theme.of(context).textTheme.headline5;
    Device().init(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: FlexibleHeaderDelegate(
              actions: actions,
              leading: leading,
              statusBarHeight: MediaQuery.of(context).padding.top,
              backgroundColor: Device.brightness == Brightness.light
                  ? Colors.white70
                  : Colors.black87,
              children: [
                FlexibleTextItem(
                  text: title,
                  collapsedStyle: _titleStyle,
                  collapsedAlignment: Alignment.center,
                  expandedAlignment: Alignment.bottomLeft,
                  expandedStyle: _titleStyle.copyWith(
                    fontSize: Device.height(7.0),
                  ),
                ),
              ],
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
      ),
    );
  }
}
