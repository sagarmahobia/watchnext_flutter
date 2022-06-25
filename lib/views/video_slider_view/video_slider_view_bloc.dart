import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/video-model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/views/video_slider_view/video_card_view/video_card_input_model.dart';

part 'video_slider_view_event.dart';

part 'video_slider_view_state.dart';

class VideoSliderViewBloc extends Bloc<VideoSliderViewEvent, VideoSliderViewState> {
  VideoSliderViewBloc() : super(VideoSliderViewInitial()) {
    on((e, emit) async {
      if (e is LoadItemsEvent) {
        TMDBService rest = getIt<TMDBService>();

        emit.call(VideoSliderViewLoading());
        try {
          Response<Videos> response = await rest.getVideos(e.type, e.id);

          List<VideoCardInputModel> cardModels = [];

          for (var result in response.body?.results ?? []) {
            if (result.site == null || result.site != "YouTube") {
              continue;
            }
            var image = "https://img.youtube.com/vi/" + (result.key ?? "") + "/mqdefault.jpg";
            var url = "https://www.youtube.com/watch?v=" + (result.key ?? "");

            var x = VideoCardInputModel(result.name ?? "", result.type ?? "", image, url);

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
