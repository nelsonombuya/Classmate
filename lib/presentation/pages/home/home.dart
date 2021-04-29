import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/notifications_widget.dart';
import '../../widgets/sign_out_button_widget.dart';
import '../dashboard/dashboard_page.dart';
import '../events/events_page.dart';
import 'custom_fab_widget.dart';
import 'home_args.dart';
import 'home_scroll_view.dart';

/// # Home
/// Acts as a wrapper around the other pages
/// So that they can share a common AppBar and Bottom Navigation Bar
class HomePage extends StatelessWidget {
  final HomeArgs args;

  HomePage({this.args});

  @override
  Widget build(BuildContext context) {
    Widget _leading;

    List<Widget> _actions = [NotificationsWidget(), SignOutButton()];

    final List<String> _titles = [
      "Dashboard",
      "Events",
      "Tasks",
      "More",
    ];

    final List<Widget> _pages = [
      DashboardPage(),
      EventsPage(),
      Container(
        color: CupertinoColors.systemYellow,
        child: Center(child: Text("TASKS")),
      ),
      Container(
        color: CupertinoColors.systemGreen,
        child: Center(child: Text("MORE")),
      ),
    ];

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
        icon: Icon(Icons.list_rounded),
        label: _titles[2],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz_rounded),
        label: _titles[3],
      )
    ];

    return HomeView(
      pages: _pages,
      titles: _titles,
      actions: _actions,
      leading: _leading,
      bottomNavBarItems: _bottomNavBarItems,
      overridePageShown: args == null ? null : args.pageToNavigateTo,
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({
    this.overridePageShown,
    @required this.pages,
    @required this.titles,
    @required this.leading,
    @required this.actions,
    @required this.bottomNavBarItems,
  });

  final Widget leading;
  final List<Widget> pages;
  final List<String> titles;
  final List<Widget> actions;
  final HomeSubPage overridePageShown;
  final List<BottomNavigationBarItem> bottomNavBarItems;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    return setState(() {
      _pageController.animateToPage(
        index,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 800),
      );
    });
  }

  void _onPageSwiped(int index) => setState(() => _currentIndex = index);

  void _overridePageShown(page) {
    switch (page) {
      case HomeSubPage.Dashboard:
        setState(() => _currentIndex = 0);
        break;

      case HomeSubPage.Events:
        setState(() => _currentIndex = 1);
        break;

      case HomeSubPage.Tasks:
        setState(() => _currentIndex = 2);
        break;

      case HomeSubPage.More:
        setState(() => _currentIndex = 3);
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // * Helps when using Sailor to navigate directly to a subpage
    // * Whilst maintaining the Home Widget's overall functionality
    _overridePageShown(widget.overridePageShown);

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: HomeScrollView(
          actions: widget.actions,
          leading: widget.leading,
          title: widget.titles[_currentIndex],
          child: PageView(
            children: widget.pages,
            controller: _pageController,
            onPageChanged: _onPageSwiped,
            physics: ClampingScrollPhysics(),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: widget.bottomNavBarItems,
      ),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }
}
