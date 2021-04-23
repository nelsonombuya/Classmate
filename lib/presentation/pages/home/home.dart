// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/events/events_page.dart';
import 'package:classmate/presentation/pages/home/home_arguments.dart';
import 'package:classmate/presentation/pages/home/home_scroll_view.dart';
import 'package:classmate/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:classmate/presentation/widgets/notifications_widget.dart';
import 'package:classmate/presentation/widgets/sign_out_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// # Home
/// Acts as a wrapper around the other pages
/// So that they can share a common AppBar and Bottom Navigation Bar
/// And also the BLoCs that may be needed to be provided among all pages
class Home extends StatelessWidget {
  final HomeArgs args;
  Home(this.args);

  @override
  Widget build(BuildContext context) {
    final AuthBloc _auth = BlocProvider.of<AuthBloc>(context);
    final UserModel _user = args.user;

    // ### App Bar
    // * Leading Widget
    Widget _leading = SignOutButton();

    // * Page Actions
    List<Widget> _actions = [NotificationsWidget()];

    // ### Content
    // * Tab Labels and Page Titles
    final List<String> _titles = [
      "Dashboard",
      "Events",
      "Add Items",
      "Tasks",
      "More",
    ];

    // * Pages
    final List<Widget> _pages = [
      DashboardPage(user: _user, authBloc: _auth),
      EventsPage(user: _user, authBloc: _auth),
      Container(color: Colors.blue, child: Center(child: Text("ADD ITEMS"))),
      Container(color: Colors.yellow, child: Center(child: Text("TASKS"))),
      Container(color: Colors.green, child: Center(child: Text("MORE"))),
    ];

    // ### Bottom Navigation Bar
    // * Bottom Navigation Bar Items
    List<BottomNavigationBarItem> _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_rounded),
        label: _titles[0],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today_rounded),
        label: _titles[1],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_rounded),
        label: _titles[2],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.check_circle_outline_rounded),
        label: _titles[3],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz_rounded),
        label: _titles[4],
      )
    ];

    return HomeView(
      user: _user,
      auth: _auth,
      pages: _pages,
      titles: _titles,
      actions: _actions,
      leading: _leading,
      bottomNavBarItems: _bottomNavBarItems,
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({
    @required this.user,
    @required this.auth,
    @required this.pages,
    @required this.titles,
    @required this.leading,
    @required this.actions,
    @required this.bottomNavBarItems,
  });

  final List<BottomNavigationBarItem> bottomNavBarItems;
  final List<Widget> actions;
  final List<String> titles;
  final List<Widget> pages;
  final Widget leading;
  final UserModel user;
  final AuthBloc auth;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // # Tab Navigation
  void _onTabTapped(int index) => setState(() => _currentIndex = index);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: HomeScrollView(
        actions: widget.actions,
        leading: widget.leading,
        child: widget.pages[_currentIndex],
        title: widget.titles[_currentIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: widget.bottomNavBarItems,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
