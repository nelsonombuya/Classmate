import 'package:sailor/sailor.dart';

enum HomeSubPage { Dashboard, Events, Tasks, More, Null }

/// # Home Args
/// Used during navigation and maybe carrying some variables
/// ! Not recommended to carry variables between pages this way
/// ! Makes things untidy 😆
class HomeArgs extends BaseArguments {
  // When you wanna use Sailor
  // to navigate to a subpage of the home page, use this
  HomeArgs({this.pageToNavigateTo});
  final HomeSubPage pageToNavigateTo;
}
