// # Imports
import 'package:classmate/presentation/init.dart';
import 'package:classmate/presentation/pages/home/home.dart';
import 'package:classmate/presentation/pages/sign_in/sign_in_page.dart';
import 'package:classmate/presentation/pages/sign_up/sign_up_page.dart';
import 'package:classmate/presentation/pages/welcome/welcome_page.dart';
import 'package:sailor/sailor.dart';

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
      SailorRoute(name: "/home", builder: (context, args, params) => Home()),
    );
  }
}
