import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';

class ClassMateLogo extends StatelessWidget {
  final Function onTap;

  ClassMateLogo({this.onTap});

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Device.width(26.0),
          height: Device.width(26.0),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/logo/white_plain.png',
            fit: BoxFit.contain,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                "Class",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: Device.height(7.0),
                      fontWeight: FontWeight.w300,
                      color: CupertinoColors.white,
                    ),
              ),
              Text(
                "Mate",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: Device.height(7.0),
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemBlue,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
