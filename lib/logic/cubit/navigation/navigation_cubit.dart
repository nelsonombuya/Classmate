import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(this.navigatorKey) : super(NavigationState());

  final GlobalKey<NavigatorState> navigatorKey;

  void popCurrentPage() => navigatorKey.currentState!.pop();
}
