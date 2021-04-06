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
      bool _loading = false; // TODO Add Loading Events
      String _firstPage = _loading ? '/dashboard' : '/welcome';
      yield LoadingComplete(firstPage: _firstPage);
    }
  }
}
