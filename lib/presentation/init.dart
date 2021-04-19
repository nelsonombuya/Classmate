import 'package:classmate/presentation/pages/dashboard/dashboard_page_arguments.dart';
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/welcome/welcome_page.dart';
import 'package:classmate/presentation/pages/splash/splash_page.dart';
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// # Init
/// Does all the necessary initializations needed when the app starts
class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Unauthenticated) return WelcomePage();

        if (state is Authenticated)
          return DashboardPage(DashboardArgs(user: state.user));

        if (state is AuthenticationError)
          return SplashPage(error: state.message);

        // * Return the splash page in the meantime
        return SplashPage();
      },
    );
  }
}
