// # Dashboard Page Arguments
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailor/sailor.dart';

class DashboardArgs extends BaseArguments {
  DashboardArgs({this.user});
  User user;
}
