// # Main App Initialization
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/splash/splash_page.dart';
import 'package:classmate/presentation/pages/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // * Main Page
          if (snapshot.connectionState == ConnectionState.done)
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial) return SplashPage();

                if (state is Authenticated)
                  return DashboardPage(user: state.user);

                if (state is Unauthenticated) return WelcomePage();

                return SplashPage();
              },
            );

          // ! In case of error
          if (snapshot.hasError) return SplashPage(error: snapshot.error);

          // * Showing the splash page in the meantime
          return SplashPage();
        },
      ),
    );
  }
}
