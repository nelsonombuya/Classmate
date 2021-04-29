import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/route.dart' as route;

class CreateANewAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(route.signUpPage),
      child: Text(
        'CREATE A NEW ACCOUNT',
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
    );
  }
}
