import 'package:flutter/material.dart';

import '../presentation/pages/home/home.dart';
import '../presentation/pages/sign_in/sign_in_page.dart';
import '../presentation/pages/sign_up/sign_up_page.dart';
import '../presentation/pages/splash/splash_page.dart';
import '../presentation/pages/welcome/welcome_page.dart';
import 'device_query.dart';

/// This route management system can be found on:
/// https://oflutter.com/organized-navigation-named-route-in-flutter/

const String root = '/';
const String welcomePage = '/welcome';
const String splashPage = '/splash';
const String signInPage = '/sign_in';
const String signUpPage = '/sign_up';
const String homePage = '/home';
const String dashboardPage = '/dashboard';
const String eventsPage = '/events';
const String tasksPage = '/tasks';
const String morePage = '/more';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case welcomePage:
      return MaterialPageRoute(
          builder: (context) => DeviceQuery(context, WelcomePage()));
    case splashPage:
      return MaterialPageRoute(
          builder: (context) => DeviceQuery(context, SplashPage()));
    case signInPage:
      return MaterialPageRoute(
          builder: (context) => DeviceQuery(context, SignInPage()));
    case signUpPage:
      return MaterialPageRoute(
          builder: (context) => DeviceQuery(context, SignUpPage()));
    case homePage:
      return MaterialPageRoute(
          builder: (context) => DeviceQuery(context, HomePage()));
    case dashboardPage:
      return MaterialPageRoute(
          builder: (context) =>
              DeviceQuery(context, HomePage(subPage: HomeSubPage.Dashboard)));
    case eventsPage:
      return MaterialPageRoute(
          builder: (context) =>
              DeviceQuery(context, HomePage(subPage: HomeSubPage.Events)));
    case tasksPage:
      return MaterialPageRoute(
          builder: (context) =>
              DeviceQuery(context, HomePage(subPage: HomeSubPage.Tasks)));
    case morePage:
      return MaterialPageRoute(
          builder: (context) =>
              DeviceQuery(context, HomePage(subPage: HomeSubPage.More)));
    default:
      throw ('This route name does not exit');
  }
}
