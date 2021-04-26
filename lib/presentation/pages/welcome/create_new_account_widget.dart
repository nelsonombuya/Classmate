import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/routes.dart';

class CreateANewAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Routes.sailor('/sign_up'),
      child: Text(
        'CREATE A NEW ACCOUNT',
        style: TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
