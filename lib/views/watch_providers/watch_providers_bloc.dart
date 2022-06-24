import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'watch_providers_event.dart';
part 'watch_providers_state.dart';

class WatchProvidersBloc extends Bloc<WatchProvidersEvent, WatchProvidersState> {
  WatchProvidersBloc() : super(WatchProvidersInitial()) {
    on<WatchProvidersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
