import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../../../constants/device_query.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int?) onTap;
  late final Color _backgroundColor;
  late final Color _selectedItemColor;
  late final TextStyle? _labelStyle;
  late final DeviceQuery _deviceQuery;
  final List<BottomNavigationBarItem> items;

  CustomBottomNavigationBar({
    required this.items,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);

    _labelStyle = (Theme.of(context).textTheme.button == null)
        ? null
        : Theme.of(context).textTheme.button!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: _deviceQuery.safeHeight(1.6),
              fontFamily: "Averta",
            );

    // TODO Manage System Colors ✨
    if (_deviceQuery.brightness == Brightness.light) {
      _backgroundColor = CupertinoColors.systemGroupedBackground;
      _selectedItemColor = CupertinoColors.black;
    } else {
      _selectedItemColor = CupertinoColors.white;
      _backgroundColor = CupertinoColors.darkBackgroundGray;
    }

    return SnakeNavigationBar.color(
      onTap: onTap,
      items: items,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      selectedLabelStyle: _labelStyle,
      unselectedLabelStyle: _labelStyle,
      snakeShape: SnakeShape.indicator,
      height: _deviceQuery.safeHeight(8),
      backgroundColor: _backgroundColor,
      snakeViewColor: _selectedItemColor,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: Theme.of(context).disabledColor,
    );
  }
}
