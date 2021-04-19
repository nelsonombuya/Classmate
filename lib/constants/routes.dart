// # Imports
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/welcome/welcome_page.dart';
import 'package:classmate/presentation/pages/sign_in/sign_in_page.dart';
import 'package:classmate/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:classmate/init.dart';
import 'package:sailor/sailor.dart';

// * Older Routes (Just in Case)
dynamic customRoutes = <String, WidgetBuilder>{
  '/': (context) => Init(),
  '/welcome': (context) => WelcomePage(),
  '/sign_in': (context) => SignInPage(),
  '/sign_up': (context) => SignUpPage(),
};

// # Sailor Routes
// TODO Add Transitions
class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoute(
      SailorRoute(name: "/", builder: (context, args, params) => Init()),
    );
    sailor.addRoute(
      SailorRoute(
          name: "/welcome", builder: (context, args, params) => WelcomePage()),
    );
    sailor.addRoute(
      SailorRoute(
          name: "/sign_in", builder: (context, args, params) => SignInPage()),
    );
    sailor.addRoute(
      SailorRoute(
          name: "/sign_up", builder: (context, args, params) => SignUpPage()),
    );
    sailor.addRoute(
      SailorRoute(
        name: "/dashboard",
        builder: (context, args, params) => DashboardPage(args),
      ),
    );
  }
}
