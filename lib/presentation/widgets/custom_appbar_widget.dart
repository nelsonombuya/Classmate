// # Imports
import 'dart:ui';

import 'package:classmate/constants/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// # Custom App Bar Widget
/// An extension of the App Bar Widget
/// Modified for the sign up and sign in screens
class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    @required this.title,
    this.actions,
    this.automaticallyImplyLeading,
  });
  final String title;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

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
            ? CupertinoColors.black
            : CupertinoColors.systemGrey4,
      ),
      backgroundColor: Device.brightness == Brightness.light
          ? CupertinoColors.systemGroupedBackground
          : CupertinoColors.darkBackgroundGray,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
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
