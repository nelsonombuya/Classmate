import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required String title,
    required IconData icon,
    required void Function()? onTap,
  })   : _title = title,
        _icon = icon,
        _onTap = onTap,
        super(key: key);

  final String _title;
  final IconData _icon;
  final void Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ListTile(
        onTap: _onTap,
        leading: Icon(_icon),
        enableFeedback: true,
        title: Text(_title, style: Theme.of(context).textTheme.headline6),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        tileColor: MediaQuery.of(context).platformBrightness == Brightness.light
            ? CupertinoColors.systemGroupedBackground
            : CupertinoColors.darkBackgroundGray,
      ),
    );
  }
}
