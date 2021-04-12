import 'dart:async';

import 'package:classmate/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({this.userRepository}) : super(DashboardInitial());
  UserRepository userRepository;

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LogoutButtonPressed) {
      await userRepository.signOut();
      yield LogoutSuccess();
    }
  }
}
