import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/cast_and_crew.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';

part 'person_slider_view_event.dart';

part 'person_slider_view_state.dart';

class PersonSliderViewBloc extends Bloc<VideoSliderViewEvent, VideoSliderViewState> {
  PersonSliderViewBloc() : super(VideoSliderViewInitial()) {
    on((e, emit) async {
      if (e is LoadItemsEvent) {
        TMDBService rest = getIt<TMDBService>();

        emit.call(VideoSliderViewLoading());
        try {
          Response response = await rest.getPeople(e.url);

          List<Cast> results = [];
          var bodyString = response.bodyString;
          if (e.isCredit) {
            var castAndCrew = castAndCrewFromJson(bodyString);
            results.addAll(castAndCrew.cast??[]);
            results.addAll(castAndCrew.crew??[]);
          } else {
            People people = peopleFromJson(bodyString);
            results = people.results??[];
          }

          List<PersonCardInputModel> cardModels = [];

          for (var result in results) {
            var image = "https://image.tmdb.org/t/p/w342" + (result.profilePath ?? "");
            var x = PersonCardInputModel(result.id ?? 0, result.name ?? "", image);

            cardModels.add(x);
          }

          emit.call(VideoSliderViewSuccess(cardModels));
        } catch (e) {
          emit.call(VideoSliderViewError(e));
        }
      }
    });
  }
}
