// # Imports
import 'package:flutter/material.dart';

/// # Transparent App Bar Widget
/// An extension of the App Bar Widget
/// Completely flat
/// With Blue Buttons
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.title});
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.blue),
      title: title == null ? null : Text(title),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
