import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/cast_and_crew.dart';
import 'package:watchnext/models/credits_model.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';

part 'person_slider_view_event.dart';

part 'person_slider_view_state.dart';

class PersonSliderViewBloc extends Bloc<VideoSliderViewEvent, PersonSliderViewState> {
  final rest = getIt<TMDBService>();
  PersonSliderViewBloc() : super(PersonSliderViewLoading()) {
    on((e, emit) async {
      if (e is LoadItemsEvent) {

        emit.call(PersonSliderViewLoading());
        try {
          if (e.isCredit) {
            List<PersonCardInputModel> cast = [];
            List<PersonCardInputModel> crew = [];

            Response<CastAndCrew> response = await rest.getCastAndCrew(e.url);

            cast.addAll((response.body?.cast ?? [])
                .map((e) => PersonCardInputModel(e.id ?? 0, e.name ?? "N/A",
                    "https://image.tmdb.org/t/p/w342" + (e.profilePath ?? "")))
                .toList());
            crew.addAll((response.body?.crew ?? [])
                .map((e) => PersonCardInputModel(e.id ?? 0, e.name ?? "N/A",
                    "https://image.tmdb.org/t/p/w342" + (e.profilePath ?? "")))
                .toList());

            emit.call(CastAndCrewCredit(cast, crew));
          } else {
            List<Cast> results = [];

            Response<People> response = await rest.getPeople(e.url);

            results = response.body?.results ?? [];
            List<PersonCardInputModel> cardModels = [];

            for (var result in results) {
              var image = "https://image.tmdb.org/t/p/w342" + (result.profilePath ?? "");
              var x = PersonCardInputModel(result.id ?? 0, result.name ?? "", image);

              cardModels.add(x);
            }

            emit.call(PersonSliderViewSuccess(cardModels));
          }
        } catch (e) {
          emit.call(PersonSliderViewError(e));
        }
      }
    });
  }
}
