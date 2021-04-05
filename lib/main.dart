// # Imports
// Packages
import 'package:classmate/constants/themes.dart';
import 'package:classmate/presentation/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoCs
import 'logic/bloc/loading_bloc.dart';

// # Launching the App
void main() => runApp(ClassMate());

/// TODO IMPLEMENT SPLASH SCREEN
/// TODO IMPLEMENT ROUTING

// # Main App Settings
class ClassMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassMate',
      theme: Themes.lightMode(),
      darkTheme: Themes.darkMode(),
      home: BlocProvider(
        create: (context) => LoadingBloc(),
        child: LoadingPage(),
      ),
    );
  }
}
