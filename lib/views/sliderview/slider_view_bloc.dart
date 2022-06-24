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
  SliderViewBloc() : super(SliderViewInitial()) {
    on((e, emit) async {
      if (e is LoadItemsEvent) {
        TMDBService rest = getIt<TMDBService>();

        emit.call(SliderViewLoading());
        try {
          Response response = await rest.getItems(e.url);

          ListResponse items = listResponseFromJson(response.bodyString);
          List<ShowCardInputModel> cardModels = [];

          for (var result in items.results ?? []) {
            var x = ShowCardInputModel(
                result.id ?? 0,
                "https://image.tmdb.org/t/p/w185" + (result.posterPath ?? ""),
                result.title != null ? (result.title ?? "N/A") : (result.name ?? "N/A"),
                e.type,
                result.voteAverage?.toStringAsFixed(1) ?? "0");

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
