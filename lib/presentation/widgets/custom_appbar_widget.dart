import 'package:flutter/material.dart';

/// * Transparent App Bar Widget
/// An extension of the App Bar Widget
/// Completely flat
/// With Blue Buttons
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.blue),
      elevation: 0.0,
    );
  }
}
