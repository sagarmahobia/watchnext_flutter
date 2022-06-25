import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/pages/person_detail/season_detail_model.dart';
import 'package:watchnext/services/tmdb_service.dart';

part 'season_detail_event.dart';

part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  SeasonDetailBloc() : super(SeasonDetailInitial()) {
    var rest = getIt<TMDBService>();
    on<SeasonDetailEvent>((event, emit) async {
      emit.call(SeasonDetailsLoading());

      if (event is LoadSeasonDetail) {
        try {
          var response = await rest.getSeasonDetail(event.tvId, event.seasonNumber);

          var seasonDetail = response.body ?? SeasonDetailModel.fromJson(jsonDecode("{}"));

          emit.call(SeasonDetailsLoaded(seasonDetail));
        } catch (e) {
          emit.call(SeasonDetailsLoadError());
        }
      }
    });
  }
}
