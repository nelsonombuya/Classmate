import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../../../constants/device_query.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required int currentIndex,
    required void Function(int?) onTap,
    required List<BottomNavigationBarItem> items,
  })   : _currentIndex = currentIndex,
        _onTap = onTap,
        _items = items;

  final int _currentIndex;
  final void Function(int?) _onTap;
  final List<BottomNavigationBarItem> _items;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);

    final TextStyle? _labelStyle = (Theme.of(context).textTheme.button == null)
        ? null
        : Theme.of(context).textTheme.button!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: _deviceQuery.safeHeight(1.6),
              fontFamily: "Averta",
            );

    var _selectedItemColor, _backgroundColor;
    if (_deviceQuery.brightness == Brightness.light) {
      _backgroundColor = CupertinoColors.systemGroupedBackground;
      _selectedItemColor = CupertinoColors.black;
    } else {
      _selectedItemColor = CupertinoColors.white;
      _backgroundColor = CupertinoColors.darkBackgroundGray;
    }

    return SnakeNavigationBar.color(
      onTap: _onTap,
      items: _items,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _currentIndex,
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
