// # Imports
import 'package:classmate/presentation/pages/welcome/welcome_page.dart';
import 'package:classmate/presentation/pages/sign_in/sign_in_page.dart';
import 'package:classmate/presentation/pages/sign_up/sign_up_page.dart';
import 'package:classmate/presentation/initializer.dart';
import 'package:flutter/material.dart';

dynamic customRoutes = <String, WidgetBuilder>{
  '/': (context) => Init(),
  '/welcome': (context) => WelcomePage(),
  '/sign_in': (context) => SignInPage(),
  '/sign_up': (context) => SignUpPage(),
};
