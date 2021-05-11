import 'package:classmate/cubit/navigation/navigation_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/events/events_bloc.dart';
import '../../../bloc/tasks/tasks_bloc.dart';
import '../../../cubit/notification/notification_cubit.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/event_repository.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../dashboard/dashboard_page.dart';
import '../events/events_page.dart';
import '../more/more_page.dart';
import '../notifications/notifications_button.dart';
import '../tasks/tasks_page.dart';
import 'home_scroll_view.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/custom_fab.dart';
import 'widgets/sign_out_button.dart';

enum HomeSubPage { Dashboard, Events, Tasks, More }

/// # Home
/// Acts as a wrapper around the other pages
/// So that they can share a common AppBar and Bottom Navigation Bar
class HomePage extends StatelessWidget {
  const HomePage({HomeSubPage? subPage}) : _subPage = subPage;

  final HomeSubPage? _subPage;

  @override
  Widget build(BuildContext context) {
    final List<Widget>? _actions = [
      NotificationsButton(),
      SignOutButton(),
    ];

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
      MorePage(),
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

    final UserRepository _userRepository = context.read<UserRepository>();
    final UserModel _user = _userRepository.getUser()!;
    final EventRepository _eventRepository = EventRepository(_user);
    final TaskRepository _taskRepository = TaskRepository(_user);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _eventRepository),
        RepositoryProvider.value(value: _taskRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EventsBloc>(
            create: (context) => EventsBloc(
              eventRepository: _eventRepository,
              navigationCubit: context.read<NavigationCubit>(),
              notificationCubit: context.read<NotificationCubit>(),
            ),
          ),
          BlocProvider<TasksBloc>(
            create: (context) => TasksBloc(
              taskRepository: _taskRepository,
              notificationCubit: context.read<NotificationCubit>(),
            ),
          ),
        ],
        child: _HomeView(
          pages: _pages,
          titles: _titles,
          actions: _actions,
          overridePageShown: _subPage,
          bottomNavigationBarItems: _bottomNavigationBarItems,
        ),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({
    Widget? leading,
    List<Widget>? actions,
    HomeSubPage? overridePageShown,
    required List<Widget> pages,
    required List<String> titles,
    required List<BottomNavigationBarItem> bottomNavigationBarItems,
  })   : _leading = leading,
        _actions = actions,
        _overridePageShown = overridePageShown,
        _pages = pages,
        _titles = titles,
        _bottomNavigationBarItems = bottomNavigationBarItems;

  final Widget? _leading;
  final List<Widget> _pages;
  final List<String> _titles;
  final List<Widget>? _actions;
  final HomeSubPage? _overridePageShown;
  final List<BottomNavigationBarItem> _bottomNavigationBarItems;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageSwiped(int index) => setState(() => _currentIndex = index);

  void _onTabTapped(int? index) {
    return setState(
      () => _pageController.animateToPage(
        index!,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 800),
      ),
    );
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
    _overridePageShown(widget._overridePageShown);

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: HomeScrollView(
          actions: widget._actions,
          leading: widget._leading,
          title: widget._titles[_currentIndex],
          child: PageView(
            children: widget._pages,
            controller: _pageController,
            onPageChanged: _onPageSwiped,
            physics: ClampingScrollPhysics(),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: widget._bottomNavigationBarItems,
      ),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }
}
