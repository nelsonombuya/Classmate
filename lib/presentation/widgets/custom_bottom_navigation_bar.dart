// # Imports
import 'package:classmate/constants/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

/// # Custom Bottom Navigation Bar
/// ! Depends on Snake Navigation Bar
/// Nicely animated Nav Bar with some personal modifications
class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({
    @required this.currentIndex,
    @required this.onTap,
    @required this.items,
  });

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    // Defining Text styles used in the widgets
    TextStyle _labelStyle = Theme.of(context).textTheme.button.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: Device.height(1.6),
          fontFamily: "Averta",
        );

    // Defining colours used in the widget
    Color _backgroundColor;
    Color _selectedItemColor;

    if (Device.brightness == Brightness.light) {
      // * Light Mode Settings
      _backgroundColor = CupertinoColors.white;
      _selectedItemColor = CupertinoColors.black;
    } else {
      // * Dark Mode Settings
      _selectedItemColor = CupertinoColors.white;
      _backgroundColor = CupertinoColors.darkBackgroundGray;
    }

    return SnakeNavigationBar.color(
      onTap: onTap,
      items: items,
      height: Device.height(8),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      selectedLabelStyle: _labelStyle,
      unselectedLabelStyle: _labelStyle,
      backgroundColor: _backgroundColor,
      snakeViewColor: _selectedItemColor,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: CupertinoColors.inactiveGray,
      snakeShape: SnakeShape.indicator,
    );
  }
}
