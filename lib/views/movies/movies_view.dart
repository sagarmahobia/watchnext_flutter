import 'package:flutter/material.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

class MoviesView extends StatefulWidget {
  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView>
    with AutomaticKeepAliveClientMixin<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: getSliderModels(),
      ),
    );
  }

  List<Widget> getSliderModels() {
    List<SliderInputModel> models = List();
    List<Widget> widgets = List();

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

    for (MovieGenres genre in MovieGenres.values) {
      models.add(
        SliderInputModel(
          url: "discover/movie?sort_by=popularity.desc&with_genres=" +
              genre.id.toString(),
          sliderTitle: getMovieGenreById(genre.id),
          pictureType: "movie",
        ),
      );
    }

    for (var value in models) {
      widgets.add(SliderView(
        inputModel: value,
      ));
    }

    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
