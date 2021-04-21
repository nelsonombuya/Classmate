// # Imports
import 'package:classmate/presentation/pages/home/custom_bottom_navigation_bar.dart';
import 'package:classmate/presentation/widgets/custom_appbar_widget.dart';
import 'package:classmate/presentation/pages/home/home_arguments.dart';
import 'package:classmate/data/models/user_model.dart';
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
  HomeView({this.user, this.auth});
  final AuthBloc auth;
  final user;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // # Tab Navigation
  void _onTabTapped(int index) => setState(() => _currentIndex = index);
  int _currentIndex = 0;

  // * Pages
  final List<Widget> _pages = [
    Text("Dashboard Page"),
    Text("Events Page"),
    Text("Add Items Page"),
    Text("Tasks Page"),
    Text("More Page"),
  ];

  // * Bottom Navigation Bar Items
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_rounded),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_rounded),
      label: 'Events',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_rounded),
      label: "Add Items",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline_rounded),
      label: 'Tasks',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz_rounded),
      label: 'More',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        items: bottomNavBarItems,
        onTap: _onTabTapped,
      ),

      // ! TO BE CHANGED
      appBar: CustomAppBar(
        title: 'DASHBOARD',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Device.brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
