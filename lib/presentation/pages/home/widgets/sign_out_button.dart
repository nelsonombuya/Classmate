import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/notification/notification_bloc.dart';

class SignOutButton extends StatelessWidget {
  late final NotificationBloc _notifications;
  @override
  Widget build(BuildContext context) {
    _notifications = BlocProvider.of<NotificationBloc>(context);

    return IconButton(
      onPressed: () => _notifications.add(SignOutDialogBoxRequested(context)),
      icon: Icon(Icons.logout, color: Theme.of(context).errorColor),
    );
  }
}
