import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';

part 'slider_view_event.dart';

part 'slider_view_state.dart';

class SliderViewBloc extends Bloc<SliderViewEvent, SliderViewState> {
  final String url;
  final String type;

  SliderViewBloc(this.url, this.type) : super(SliderViewInitial());

  @override
  Stream<SliderViewState> mapEventToState(
    SliderViewEvent e,
  ) async* {
    if (e is LoadItemsEvent) {
      TMDBService rest = getIt<TMDBService>();

      yield SliderViewLoading();
      try {
        Response response = await rest.getItems(this.url);

        ListResponse items = listResponseFromJson(response.bodyString);
        List<ShowCardInputModel> cardModels = List();

        for (var result in items.results) {
          var x = ShowCardInputModel(
              result.id,
              "https://image.tmdb.org/t/p/w185" +
                  (result.posterPath != null ? result.posterPath : ""),
              result.title != null ? result.title : result.name,
              this.type,
              result.voteAverage);

          cardModels.add(x);
        }

        yield SliderViewSuccess(cardModels);
      } catch (e) {
        yield SliderViewError(e);
      }
    }
  }
}
