import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/authentication_repository.dart';
import '../logic/bloc/authentication/authentication_bloc.dart';
import '../presentation/pages/home/home.dart';
import '../presentation/pages/splash/splash_page.dart';
import '../presentation/pages/welcome/welcome_page.dart';

/// # Redirect To First Page
/// Uses BLoC Builder to redirect to either the
///   * Splash Page
///     When Loading
///   * Welcome Page
///     When unauthenticated
///   * Home Page
///     When authenticated
/// ! Make sure Authentication BLoC is in the Global BLoC Providers
class RedirectToFirstPage extends StatelessWidget {
  const RedirectToFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            return HomePage();
          case AuthenticationStatus.unauthenticated:
            return WelcomePage();
          default:
            return SplashPage();
        }
      },
    );
  }
}
