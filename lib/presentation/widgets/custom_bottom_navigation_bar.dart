// # Imports
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

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
    Color _unselectedItemColor;

    if (Device.brightness == Brightness.light) {
      // * Light Mode Settings
      _backgroundColor = Colors.white70;
      _selectedItemColor = Colors.black87;
      _unselectedItemColor = Colors.black38;
    } else {
      // * Dark Mode Settings
      _backgroundColor = Colors.black87;
      _selectedItemColor = Colors.white70;
      _unselectedItemColor = Colors.white38;
    }

    return SnakeNavigationBar.color(
      onTap: onTap,
      items: items,
      elevation: 2.0,
      height: Device.height(8),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      snakeShape: SnakeShape.indicator,
      selectedLabelStyle: _labelStyle,
      unselectedLabelStyle: _labelStyle,
      backgroundColor: _backgroundColor,
      snakeViewColor: _selectedItemColor,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: _unselectedItemColor,
      behaviour: SnakeBarBehaviour.floating,
    );
  }
}
