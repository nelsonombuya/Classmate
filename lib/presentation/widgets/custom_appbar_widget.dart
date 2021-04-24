// # Imports
import 'dart:ui';

import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Custom App Bar Widget
/// An extension of the App Bar Widget
/// Modified for the sign up and sign in screens
class CustomAppBar extends StatelessWidget {
  CustomAppBar({@required this.title, this.actions});
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      actions: actions,
      expandedHeight: kToolbarHeight * 3.0,
      iconTheme: IconThemeData(
        color: Device.brightness == Brightness.light
            ? Colors.black87
            : Colors.white70,
      ),
      backgroundColor: Device.brightness == Brightness.light
          ? Colors.grey[50]
          : Colors.black87,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: Device.height(1.6)),
        title: title == null
            ? null
            : Text(
                title.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
