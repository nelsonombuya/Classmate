// # Imports
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/events/events_page.dart';
import 'package:classmate/presentation/pages/home/home_arguments.dart';
import 'package:classmate/presentation/pages/home/home_scroll_view.dart';
import 'package:classmate/presentation/widgets/avatar_widget.dart';
import 'package:classmate/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:classmate/presentation/widgets/notifications_widget.dart';
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

    return HomeView(user: _user, auth: _auth);
  }
}

class HomeView extends StatefulWidget {
  HomeView({@required this.user, @required this.auth});
  final UserModel user;
  final AuthBloc auth;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // # Tab Navigation
  void _onTabTapped(int index) => setState(() => _currentIndex = index);
  int _currentIndex = 0;

  // * Tab Labels and Page Titles
  final List<String> _labels = [
    "Dashboard",
    "Events",
    "Add Items",
    "Tasks",
    "More",
  ];

  @override
  Widget build(BuildContext context) {
    // * For Measurements
    Device().init(context);

    // * Pages
    final List<Widget> _pages = [
      DashboardPage(user: widget.user, authBloc: widget.auth),
      EventsPage(user: widget.user, authBloc: widget.auth),
      Container(color: Colors.green),
      Container(color: Colors.blue),
      Container(),
    ];

    // * Bottom Navigation Bar Items
    List<BottomNavigationBarItem> _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_rounded),
        label: _labels[0],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today_rounded),
        label: _labels[1],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_rounded),
        label: _labels[2],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.check_circle_outline_rounded),
        label: _labels[3],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz_rounded),
        label: _labels[4],
      )
    ];

    // * Page Actions
    Map<int, List<Widget>> _pageActions = {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
    };

    return Scaffold(
      extendBody: true,
      body: HomeScrollView(
        pages: _pages,
        labels: _labels,
        currentIndex: _currentIndex,
        actions: List<Widget>.from(_pageActions[_currentIndex])
          ..add(NotificationsWidget()),
        leading: Avatar(initials: widget.user.initials, authBloc: widget.auth),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavBarItems,
        onTap: _onTabTapped,
      ),
    );
  }
}
