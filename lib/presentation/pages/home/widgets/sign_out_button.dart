import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/notification/notification_cubit.dart';

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout, color: Theme.of(context).errorColor),
      onPressed: () => context.read<NotificationCubit>().showSignOutDialog(),
    );
  }
}
