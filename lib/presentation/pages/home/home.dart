// # Imports
import 'package:classmate/constants/device.dart';
import 'package:classmate/presentation/pages/dashboard/dashboard_page.dart';
import 'package:classmate/presentation/pages/events/events_page.dart';
import 'package:classmate/presentation/pages/home/add_event_form.dart';
import 'package:classmate/presentation/pages/home/home_args.dart';
import 'package:classmate/presentation/pages/home/home_scroll_view.dart';
import 'package:classmate/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:classmate/presentation/widgets/notifications_widget.dart';
import 'package:classmate/presentation/widgets/sign_out_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// # Home
/// Acts as a wrapper around the other pages
/// So that they can share a common AppBar and Bottom Navigation Bar
/// And also the BLoCs that may be needed to be provided among all pages
class Home extends StatelessWidget {
  // # Getting the subpage (if needed)
  Home({this.args});
  final HomeArgs args;

  // # Use to provide BLoCs and variables to the rest of the app
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
      "Tasks",
      "More",
    ];

    // * Pages
    final List<Widget> _pages = [
      DashboardPage(),
      EventsPage(),
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
        icon: Icon(Icons.check_circle_outline_rounded),
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
      overrideFirstPage:
          args == null ? HomeSubPage.Null : args.pageToNavigateTo,
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({
    this.overrideFirstPage,
    @required this.pages,
    @required this.titles,
    @required this.leading,
    @required this.actions,
    @required this.bottomNavBarItems,
  });

  final List<BottomNavigationBarItem> bottomNavBarItems;
  final HomeSubPage overrideFirstPage;
  final List<Widget> actions;
  final List<String> titles;
  final List<Widget> pages;
  final Widget leading;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // # Page Management
  int _currentIndex = 0;

  // # Tab Navigation
  void _onTabTapped(int index) {
    return setState(() {
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

  // # In case we want to override the first page
  void _overrideFirstPage(page) {
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
    _overrideFirstPage(widget.overrideFirstPage);
    Device().init(context);

    return Scaffold(
      extendBody: true,
      floatingActionButton: SpeedDial(
        tooltip: "Add Items",
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Device.brightness == Brightness.light
            ? Colors.white.withOpacity(0.9)
            : Colors.grey[800].withOpacity(0.8),
        curve: Curves.fastLinearToSlowEaseIn,
        children: [
          SpeedDialChild(
              label: "Add Event",
              child: Icon(Icons.event),
              onTap: () => showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(child: AddEventForm()),
                  )),
          SpeedDialChild(
            label: "Add Task",
            child: Icon(Icons.check_circle_outline_rounded),
          ),
        ],
      ),
      body: HomeScrollView(
        actions: widget.actions,
        leading: widget.leading,
        title: widget.titles[_currentIndex],
        child: PageView(
          physics: ClampingScrollPhysics(),
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
