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
  TMDBService rest = getIt<TMDBService>();

  String query = "";

  PictureListBloc() : super(ListPageInitial()) {
    on((event, emit) async {
      emit.call(ListPageLoading());
      try {
        if (event is LoadNextPage) {
          Response<ListResponse> response =
              await rest.getItems(event.url, page: event.page, query: query);

          ListResponse? items = response.body;

          List<ShowCardInputModel> cards = [];

          for (var result in items?.results ?? []) {
            var x = ShowCardInputModel(
                result.id ?? 0,
                "https://image.tmdb.org/t/p/w342" + (result.posterPath ?? ""),
                result.title != null ? (result.title ?? "N/A") : (result.name ?? "N/A"),
                event.pictureType,
                result.voteAverage?.toStringAsFixed(1) ?? "0");

            cards.add(x);
          }

          emit.call(ListPageLoaded(cards, event.page + 1));
        }
      } catch (e) {
        emit.call(ListPageError(e));
      }
    });
  }
}
