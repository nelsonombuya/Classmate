import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInProgress());

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    if (event is LoadingStarted) {
      // TODO Add Loading Tasks
      await Future.delayed(Duration(seconds: 8));
      bool loading = false;
      if (loading) {
        yield LoadingComplete(firstPage: '/dashboard');
      } else {
        yield LoadingComplete(firstPage: '/welcome');
      }
    }
  }
}
