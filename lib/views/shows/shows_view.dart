import 'package:flutter/material.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

class ShowsView extends StatefulWidget {
  @override
  _ShowsViewState createState() => _ShowsViewState();
}

class _ShowsViewState extends State<ShowsView>
    with AutomaticKeepAliveClientMixin<ShowsView> {
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
              "TV Shows",
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
        url: "trending/tv/week",
        sliderTitle: "Trending",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/airing_today",
        sliderTitle: "Airing Today",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "discover/tv?sort_by=popularity.desc&with_networks=213",
        sliderTitle: "Netflix",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "discover/tv?sort_by=popularity.desc&with_networks=1024",
        sliderTitle: "Amazon Shows",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "discover/tv?sort_by=popularity.desc&with_networks=2552",
        sliderTitle: "Apple TV",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "discover/tv?sort_by=popularity.desc&with_networks=2739",
        sliderTitle: "Disney Plus",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/on_the_air",
        sliderTitle: "On The Air",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/popular",
        sliderTitle: "Popular",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/top_rated",
        sliderTitle: "Top Rated",
        pictureType: "tv",
      ),
    );

    for (TVGenres genre in TVGenres.values) {
      models.add(
        SliderInputModel(
          url: "discover/movie?sort_by=popularity.desc&with_genres=" +
              genre.id.toString(),
          sliderTitle: getTvGenreById(genre.id),
          pictureType: "tv",
        ),
      );
    }

    for (var value in models) {
      widgets.add(SliderView(
        inputModel: value,
      ));
    }

    // widgets.add(
    //   PersonSliderView(
    //       inputModel: PersonSliderInputModel(
    //     "person/popular",
    //     "Popular",
    //   )),
    // );

    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
