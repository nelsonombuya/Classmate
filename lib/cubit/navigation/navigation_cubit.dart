import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(this.navigatorKey) : super(NavigationInitial());

  final GlobalKey<NavigatorState> navigatorKey;
}
