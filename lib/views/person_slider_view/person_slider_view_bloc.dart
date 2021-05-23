import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';

part 'person_slider_view_event.dart';

part 'person_slider_view_state.dart';

class PersonSliderViewBloc
    extends Bloc<VideoSliderViewEvent, VideoSliderViewState> {
  final String url;

  final bool isCredit;

  PersonSliderViewBloc(this.url, {this.isCredit = false})
      : super(VideoSliderViewInitial());

  @override
  Stream<VideoSliderViewState> mapEventToState(
    VideoSliderViewEvent e,
  ) async* {
    if (e is LoadItemsEvent) {
      TMDBService rest = getIt<TMDBService>();

      yield VideoSliderViewLoading();
      try {
        Response response = await rest.getPeople(this.url);

        List<Result> results;
        if (this.isCredit) {
          results = peopleForCredit(response.bodyString);
        } else {
          People people = peopleFromJson(response.bodyString);
          results = people.results;
        }

        List<PersonCardInputModel> cardModels = [];

        for (var result in results) {
          var image = "https://image.tmdb.org/t/p/w342" +
              (result.profilePath != null ? result.profilePath : "");
          var x = PersonCardInputModel(result.id, result.name, image);

          cardModels.add(x);
        }

        yield VideoSliderViewSuccess(cardModels);
      } catch (e) {
        yield VideoSliderViewError(e);
      }
    }
  }
}
