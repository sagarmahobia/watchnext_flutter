import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';

part 'people_list_event.dart';

part 'people_list_state.dart';

class PeopleListBloc extends Bloc<PeopleListEvent, PeopleListState> {
  TMDBService rest = getIt<TMDBService>();

  PeopleListBloc() : super(PeopleListInitial()) {
    on((event, emit) async {
      emit.call(PeoplePageLoading());
      try {
        if (event is LoadNextPage) {
          Response response = await rest.getPeople(event.url, page: event.page);

          People items = peopleFromJson(response.bodyString);

          List<PersonCardInputModel> cards = [];

          for (var result in items.results??[]) {
            var x = PersonCardInputModel(
              result.id ?? 0,
              result.name ?? "N/A",
              "https://image.tmdb.org/t/p/w342" + (result.profilePath ?? ""),
            );

            cards.add(x);
          }

          emit.call(PeoplePageLoaded(cards, event.page + 1));
        }
      } catch (e) {
        emit.call(PeoplePageError(e));
      }
    });
  }
}
