import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';

part 'picture_list_event.dart';

part 'picture_list_state.dart';

class PictureListBloc extends Bloc<PictureListEvent, PictureListState> {
  String url;

  String type;
  TMDBService rest;

  String query = "";

  PictureListBloc(this.url, this.type) : super(ListPageInitial()) {
    rest = getIt<TMDBService>();
  }

  @override
  Stream<PictureListState> mapEventToState(
    PictureListEvent event,
  ) async* {
    yield ListPageLoading();
    try {
      Response response;

      if (event is LoadNextPage) {
        response =
            await rest.getItems(url, page: event.page, query: query ?? "");

        ListResponse items = listResponseFromJson(response.bodyString);

        List<ShowCardInputModel> cards = List();

        for (var result in items.results) {
          var x = ShowCardInputModel(
              result.id,
              "https://image.tmdb.org/t/p/w342" +
                  (result.posterPath != null ? result.posterPath : ""),
              result.title != null ? result.title : result.name,
              type,
              result.voteAverage.toStringAsFixed(1));

          cards.add(x);
        }

        yield ListPageLoaded(cards, event.page + 1);
      }
    } catch (e) {
      yield ListPageError(e);
    }
  }
}
