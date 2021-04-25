// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/bloc/notifications/notifications_bloc.dart';
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

/// ## Flutter App Settings
/// Best place to add global BLoC Providers
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthStarted()),
        ),
        BlocProvider<NotificationsBloc>(
          create: (context) =>
              NotificationsBloc()..add(NotificationsServiceStarted()),
        ),
      ],
      child: MaterialApp(
        // # Sailor Navigation
        // These are used by sailor plugin to ease navigation
        navigatorObservers: [SailorLoggingObserver()],
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,

        // # Themes
        darkTheme: Themes.darkTheme,
        theme: Themes.lightTheme,

        title: 'ClassMate',
      ),
    );
  }
}
