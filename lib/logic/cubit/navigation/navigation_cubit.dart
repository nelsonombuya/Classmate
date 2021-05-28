import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(this.navigatorKey) : super(NavigationState());

  final GlobalKey<NavigatorState> navigatorKey;

  void popCurrentPage() => navigatorKey.currentState!.pop();
}

class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}
