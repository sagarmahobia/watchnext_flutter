import 'package:flutter/material.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

class MoviesView extends StatefulWidget {
  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> with AutomaticKeepAliveClientMixin<MoviesView> {
  var reload = IntCubit();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),

      child: Column(
        children: getSliderModels(),
      ),
    );
  }

  List<Widget> getSliderModels() {
    List<SliderInputModel> models = [];
    List<Widget> widgets = [];

    widgets.addAll(
      [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 0),
            child: Text(
              "Movies",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );

    models.add(
      SliderInputModel(
        url: "trending/movie/week",
        sliderTitle: "Trending",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/now_playing",
        sliderTitle: "In Theaters",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/upcoming",
        sliderTitle: "Upcoming",
        pictureType: "movie",
      ),
    );

    models.add(SliderInputModel(isAd: true));

    models.add(
      SliderInputModel(
        url: "movie/popular",
        sliderTitle: "Popular",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/top_rated",
        sliderTitle: "Top Rated",
        pictureType: "movie",
      ),
    );
    int count = 1;
    for (MovieGenres genre in MovieGenres.values) {
      if (count == 3) {
        models.add(SliderInputModel(isAd: true));
        count = 1;
      } else {
        count++;
      }
      models.add(
        SliderInputModel(
          url: "discover/movie?sort_by=popularity.desc&with_genres=" + genre.id.toString(),
          sliderTitle: getMovieGenreById(genre.id),
          pictureType: "movie",
        ),
      );
    }

    for (var value in models) {
      if (value.isAd) {
        widgets.add(
          NativeAdView(true),
        );
      } else {
        widgets.add(
          SliderView(
            reload: reload,
            inputModel: value,
          ),
        );
      }
    }

    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
