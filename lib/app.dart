// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/routes.dart';
import 'package:classmate/constants/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

// # Flutter App Settings
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthStarted()),
      child: MaterialApp(
        navigatorObservers: [SailorLoggingObserver()], // * For Navigation Logs
        onGenerateRoute: Routes.sailor.generator(), // * For Routes (Sailor)
        navigatorKey: Routes.sailor.navigatorKey, // * For Routes (Sailor)
        darkTheme: Themes.darkTheme,
        theme: Themes.lightTheme,
        title: 'ClassMate',
      ),
    );
  }
}
