import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc() : super(HomeViewInitial());

  @override
  Stream<HomeViewState> mapEventToState(
    HomeViewEvent event,
  ) async* {

  }
}
