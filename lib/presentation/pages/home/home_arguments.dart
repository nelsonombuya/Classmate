// # Dashboard Page Arguments
import 'package:classmate/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:sailor/sailor.dart';

class HomeArgs extends BaseArguments {
  HomeArgs({@required this.user});
  UserModel user;
}
