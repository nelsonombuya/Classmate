import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device_query.dart';

class HomeScrollView extends StatelessWidget {
  const HomeScrollView({
    String? title,
    Widget? leading,
    List<Widget>? actions,
    required PageView child,
  })   : _child = child,
        _title = title,
        _leading = leading,
        _actions = actions;

  final PageView _child;
  final String? _title;
  final Widget? _leading;
  final List<Widget>? _actions;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            elevation: 0.0,
            actions: _actions,
            leading: _leading,
            expandedHeight: kToolbarHeight * 3.0,
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
                  : Text(_title!, style: Theme.of(context).textTheme.headline5),
            ),
          ),
        ];
      },
      body: _child,
    );
  }
}
