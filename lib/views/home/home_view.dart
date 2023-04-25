// import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/services/pref_manager.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/attribute/tmdb_attribute.dart';
import 'package:watchnext/views/person_slider_view/person_slider_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_slider_view.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

final testUrl = "trending/movie/week";

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
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
        SizedBox(
          height: 8,
        ),
        Text(
          "WatchNext",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
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
        url: "trending/tv/week",
        sliderTitle: "Trending",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(isAd: true),
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
      SliderInputModel(isAd: true),
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
        url: "tv/on_the_air",
        sliderTitle: "On The Air",
        pictureType: "tv",
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
        url: "tv/popular",
        sliderTitle: "Popular",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/top_rated",
        sliderTitle: "Top Rated",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/top_rated",
        sliderTitle: "Top Rated",
        pictureType: "tv",
      ),
    );

    models.add(SliderInputModel(isAd: true));

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
      PersonSliderView(
        inputModel: PersonSliderInputModel("person/popular", "Popular"),
      ),
    );

    widgets.add(
      TmdbAttribution(
        type: Type.wide,
      ),
    );

    widgets.add(
      Container(
        height: 8,
      ),
    );
    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
