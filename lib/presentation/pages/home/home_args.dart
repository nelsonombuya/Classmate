import 'package:sailor/sailor.dart';

enum HomeSubPage { Dashboard, Events, Tasks, More }

class HomeArgs extends BaseArguments {
  final HomeSubPage pageToNavigateTo;

  HomeArgs({this.pageToNavigateTo});
}
