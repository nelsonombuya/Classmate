import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/notification/notification_bloc.dart';
import 'constants/routes.dart';
import 'constants/themes.dart';

/// # ClassMate
/// * Best place to add global BLoC Providers
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthStarted()),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: [SailorLoggingObserver()],
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        darkTheme: Themes.darkTheme,
        theme: Themes.lightTheme,
        title: 'ClassMate',
      ),
    );
  }
}
