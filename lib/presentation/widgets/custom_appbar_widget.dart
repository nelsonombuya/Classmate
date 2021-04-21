// # Imports
import 'package:flutter/material.dart';

/// # Transparent App Bar Widget
/// An extension of the App Bar Widget
/// Completely flat
/// With Blue Buttons
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.title, this.actions});
  final List<Widget> actions;
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: title == null
          ? null
          : Text(title, style: Theme.of(context).textTheme.headline5),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.blue),
      actions: actions,
    );
  }
}
