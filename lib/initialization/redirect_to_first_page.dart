import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication/authentication_bloc.dart';
import '../constants/device_query.dart';
import '../data/repositories/authentication_repository.dart';
import '../presentation/pages/home/home.dart';
import '../presentation/pages/splash/splash_page.dart';
import '../presentation/pages/welcome/welcome_page.dart';

/// # Redirect To First Page
//  Contains
///   * Device Query
///     Used to scale widgets consistently among devices
///     Also used to provide MediaQuery Data
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
    return DeviceQuery(
      context: context,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
      ),
    );
  }
}
