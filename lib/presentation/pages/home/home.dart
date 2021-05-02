import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event/event_bloc.dart';
import '../../../bloc/task/task_bloc.dart';
import '../dashboard/dashboard_page.dart';
import '../events/events_page.dart';
import '../tasks/tasks_page.dart';
import 'home_scroll_view.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/custom_fab.dart';
import 'widgets/notifications_button.dart';
import 'widgets/sign_out_button.dart';

enum HomeSubPage { Dashboard, Events, Tasks, More }

/// # Home
/// Acts as a wrapper around the other pages
/// So that they can share a common AppBar and Bottom Navigation Bar
class HomePage extends StatelessWidget {
  final HomeSubPage? _subPage;

  HomePage({subPage}) : _subPage = subPage;

  @override
  Widget build(BuildContext context) {
    final List<Widget>? _actions = [NotificationsButton(), SignOutButton()];

    final List<String> _titles = [
      "Dashboard",
      "Events",
      "Tasks",
      "More",
    ];

    final List<Widget> _pages = [
      DashboardPage(),
      EventsPage(),
      TasksPage(),
      Container(
        color: CupertinoColors.systemGreen,
        child: Center(child: Text("MORE")),
      ),
    ];

    final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
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

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventBloc>(create: (context) => EventBloc(context)),
        BlocProvider<TaskBloc>(create: (context) => TaskBloc(context)),
      ],
      child: HomeView(
        pages: _pages,
        titles: _titles,
        actions: _actions,
        overridePageShown: _subPage,
        bottomNavigationBarItems: _bottomNavigationBarItems,
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({
    this.leading,
    this.actions,
    this.overridePageShown,
    required this.pages,
    required this.titles,
    required this.bottomNavigationBarItems,
  });

  final Widget? leading;
  final List<Widget> pages;
  final List<String> titles;
  final List<Widget>? actions;
  final HomeSubPage? overridePageShown;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageSwiped(int index) => setState(() => _currentIndex = index);

  // TODO Implement Error Handling
  void _onTabTapped(int? index) {
    if (index == null) throw Exception("Page index can't be null. ❗");
    return setState(() {
      _pageController.animateToPage(
        index,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 800),
      );
    });
  }

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
    // * Helps to navigate directly to a subpage
    // * Whilst maintaining the Home Widget's overall functionality as a wrapper
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
        items: widget.bottomNavigationBarItems,
      ),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }
}
