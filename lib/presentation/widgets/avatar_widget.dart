import 'package:flutter/material.dart';

import '../../constants/device.dart';

/// # Avatar Widget
/// Used on the App Bar to allow the user to perform various account functions
class Avatar extends StatelessWidget {
  Avatar({this.image, this.initials});
  final ImageProvider image;
  final String initials;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return IconButton(
      onPressed: () {},
      icon: CircleAvatar(
        backgroundColor: image != null ? null : Colors.white70,
        child: image != null ? null : Text(initials),
        backgroundImage: image,
      ),
    );
  }
}
