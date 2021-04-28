import 'package:flutter/material.dart';

import '../presentation/init.dart';
import '../presentation/pages/home/home.dart';
import '../presentation/pages/sign_in/sign_in_page.dart';
import '../presentation/pages/sign_up/sign_up_page.dart';
import '../presentation/pages/splash/splash_page.dart';
import '../presentation/pages/welcome/welcome_page.dart';

const String initPage = 'init';
const String welcomePage = 'welcome';
const String splashPage = 'splash';
const String signInPage = 'sign_in';
const String signUpPage = 'sign_up';
const String homePage = 'home';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case initPage:
      return MaterialPageRoute(builder: (context) => Init());
    case welcomePage:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case splashPage:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case signInPage:
      return MaterialPageRoute(builder: (context) => SignInPage());
    case signUpPage:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    default:
      throw ('This route name does not exit');
  }
}
