// # Imports
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/events/events_page.dart';
import 'package:classmate/presentation/pages/home/home_scroll_view.dart';
import 'package:classmate/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:classmate/presentation/widgets/notifications_widget.dart';
import 'package:classmate/presentation/widgets/sign_out_button_widget.dart';
import 'package:flutter/material.dart';

/// # Home
/// Acts as a wrapper around the other pages
/// So that they can share a common AppBar and Bottom Navigation Bar
/// And also the BLoCs that may be needed to be provided among all pages
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      DashboardPage(),
      EventsPage(),
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

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // # Tab Navigation
  void _onTabTapped(int index) {
    return setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 800),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  // # Page Swipe Navigation
  void _onPageSwipe(int index) => setState(() => _currentIndex = index);

  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: HomeScrollView(
        actions: widget.actions,
        leading: widget.leading,
        title: widget.titles[_currentIndex],
        child: PageView(
          onPageChanged: _onPageSwipe,
          controller: _pageController,
          children: widget.pages,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: widget.bottomNavBarItems,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
