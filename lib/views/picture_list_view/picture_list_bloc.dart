import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';

part 'picture_list_event.dart';

part 'picture_list_state.dart';

class PictureListBloc extends Bloc<PictureListEvent, PictureListState> {
  final rest = getIt<TMDBService>();

  String query = "";

  PictureListBloc() : super(ListPageLoading()) {
    on((event, emit) async {
      emit.call(ListPageLoading());
      try {
        if (event is LoadNextPage) {
          Response<ListResponse> response =
              await rest.getItems(event.url, page: event.page, query: query);

          ListResponse? items = response.body;

          List<ShowCardInputModel> cards = [];

          for (Show result in items?.results ?? []) {
            //todo adult filter
            // if(result.adult??false){
            //   if(!getIt<PrefsManager>().isAdult()){
            //     continue;
            //   }
            // }

            var x = ShowCardInputModel(
                result.id ?? 0,
                getImageUrlPosterLQ(result.posterPath ?? ""),
                getImageUrlBackdropLQ(result.backdropPath ?? ""),
                result.title != null ? (result.title ?? "N/A") : (result.name ?? "N/A"),
                event.pictureType,
                result.voteAverage?.toStringAsFixed(1) ?? "0",
                result.voteCount ?? 0,
                result.releaseDate);

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
