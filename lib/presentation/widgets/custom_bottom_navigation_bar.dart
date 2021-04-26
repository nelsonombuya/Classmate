import 'package:classmate/constants/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function onTap;

  CustomBottomNavigationBar({
    @required this.currentIndex,
    @required this.onTap,
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    TextStyle _labelStyle = Theme.of(context).textTheme.button.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: Device.height(1.6),
          fontFamily: "Averta",
        );

    Color _backgroundColor;
    Color _selectedItemColor;

    if (Device.brightness == Brightness.light) {
      _backgroundColor = CupertinoColors.systemGroupedBackground;
      _selectedItemColor = CupertinoColors.black;
    } else {
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
