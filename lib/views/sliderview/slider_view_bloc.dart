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
  final rest = getIt<TMDBService>();

  SliderViewBloc() : super(SliderViewLoading()) {
    on((e, emit) async {
      if (e is LoadItemsEvent) {
        emit.call(SliderViewLoading());
        try {
          Response<ListResponse> response = await rest.getItems(e.url);

          List<ShowCardInputModel> cardModels = [];

          for (Show result in response.body?.results ?? []) {

            //todo adult filter
            // if(result.adult??false){
            //   if(!getIt<PrefsManager>().isAdult()){
            //     continue;
            //   }
            // }

            var x = ShowCardInputModel(
                result.id ?? 0,
                "https://image.tmdb.org/t/p/w185" + (result.posterPath ?? ""),
                "https://image.tmdb.org/t/p/w300" + (result.backdropPath ?? ""),

                result.title != null ? (result.title ?? "N/A") : (result.name ?? "N/A"),
                e.type,
                result.voteAverage?.toStringAsFixed(1) ?? "0",
                result.voteCount ?? 0,result.releaseDate);

            cardModels.add(x);
          }

          emit.call(SliderViewSuccess(cardModels));
        } catch (e) {
          emit.call(SliderViewError(e));
        }
      }
    });
  }
}
