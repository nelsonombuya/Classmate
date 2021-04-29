import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// # Avatar Widget
/// Used on the App Bar to allow the user to perform various account functions
class Avatar extends StatelessWidget {
  Avatar({this.image, this.displayName, @required this.onPressed});
  final ImageProvider image;
  final String displayName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
        backgroundImage: image,
        backgroundColor:
            image != null ? null : CupertinoColors.systemGroupedBackground,
        child:
            image != null ? null : Text(displayName[0].toUpperCase() ?? "N/A"),
      ),
    );
  }
}
