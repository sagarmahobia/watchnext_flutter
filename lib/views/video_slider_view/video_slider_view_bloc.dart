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

class VideoSliderViewBloc
    extends Bloc<VideoSliderViewEvent, VideoSliderViewState> {
  final int id;

  final String type;

  VideoSliderViewBloc(this.id, this.type) : super(VideoSliderViewInitial());

  @override
  Stream<VideoSliderViewState> mapEventToState(
    VideoSliderViewEvent e,
  ) async* {
    if (e is LoadItemsEvent) {
      TMDBService rest = getIt<TMDBService>();

      yield VideoSliderViewLoading();
      try {
        Response response = await rest.getVideos(type, id);

        Videos items = videosFromJson(response.bodyString);
        List<VideoCardInputModel> cardModels = List();

        for (var result in items.results) {
          if (result.site == null || result.site != "YouTube") {
            continue;
          }
          var image =
              "https://img.youtube.com/vi/" + result.key + "/mqdefault.jpg";
          var url = "https://www.youtube.com/watch?v=" + result.key;

          var x = VideoCardInputModel(result.name, result.type, image, url);

          cardModels.add(x);
        }

        yield VideoSliderViewSuccess(cardModels);
      } catch (e) {
        yield VideoSliderViewError(e);
      }
    }
  }
}
