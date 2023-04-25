import 'dart:math';

import 'package:flutter/material.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/pages/picture_list/list_page.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

import '../attribute/tmdb_attribute.dart';

class MoviesView extends StatefulWidget {
  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView>
    with AutomaticKeepAliveClientMixin<MoviesView> {
  var reload = IntCubit();
  final rotatingColor = RotatingColor();

  bool isCollapsed = true;

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
        ),
        SizedBox(
          height: 16,
        ),
        //explore by genre section

        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Explore by Genres",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),

        Container(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.6,
            padding: EdgeInsets.all(16),
            children: MovieGenres.values.sublist(0, isCollapsed?5:null).map(
              (e) {
                var withOpacity =
                    rotatingColor.getColor().shade900.withOpacity(0.4);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListPage(
                          url: "discover/movie?sort_by=popularity.desc&with_genres=" + e.id.toString(),
                          pictureType: "movie",
                          title: getMovieGenreById(e.id),
                          color: withOpacity,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: withOpacity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          getMovieGenreById(e.id),
                          textAlign: TextAlign.center,
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            height: 1.5,
                            
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList()..add(
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
                child: Container(
                  color: Colors.red.shade900.withOpacity(.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isCollapsed ? "More" : "Less",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        isCollapsed ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: Colors.white,
                        size: 22,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: 16,
        )
      ],
    );

    //6 initial elements with end one being more button



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
          url: "discover/movie?sort_by=popularity.desc&with_genres=" +
              genre.id.toString(),
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
    widgets.add(
      TmdbAttribution(
        type: Type.wide,
      ),
    );

    widgets.add(
      SizedBox(
        height: 8,
      ),
    );

    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
