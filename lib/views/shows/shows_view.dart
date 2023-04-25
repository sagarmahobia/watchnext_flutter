import 'package:flutter/material.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/pages/picture_list/list_page.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

import '../attribute/tmdb_attribute.dart';

class ShowsView extends StatefulWidget {
  @override
  _ShowsViewState createState() => _ShowsViewState();
}

class _ShowsViewState extends State<ShowsView>
    with AutomaticKeepAliveClientMixin<ShowsView> {
  var reload = IntCubit();

  var isCollapsed = true;

  var rotatingColor = RotatingColor();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: getSliderModels(),
        ),
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
              "TV Shows",
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
            children: TVGenres.values.sublist(0, isCollapsed ? 5 : null).map(
              (e) {
                var withOpacity =
                    rotatingColor.getColor().shade900.withOpacity(0.4);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListPage(
                          url:
                              "discover/tv?sort_by=popularity.desc&with_genres=" +
                                  e.id.toString(),
                          pictureType: "tv",
                          title: getTvGenreById(e.id),
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
                          getTvGenreById(e.id),
                          textAlign: TextAlign.center,
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            height: 1.5,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList()
              ..add(
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
                          isCollapsed
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
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
      SliderInputModel(isAd: true),
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
      SliderInputModel(isAd: true),
    );

    models.add(
      SliderInputModel(
        url: "tv/top_rated",
        sliderTitle: "Top Rated",
        pictureType: "tv",
      ),
    );
    var count = 1;
    for (TVGenres genre in TVGenres.values) {
      if (count == 3) {
        models.add(SliderInputModel(isAd: true));
        count = 1;
      } else {
        count++;
      }
      models.add(
        SliderInputModel(
          url: "discover/tv?sort_by=popularity.desc&with_genres=" +
              genre.id.toString(),
          sliderTitle: getTvGenreById(genre.id),
          pictureType: "tv",
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
    // widgets.add(
    //   PersonSliderView(
    //       inputModel: PersonSliderInputModel(
    //     "person/popular",
    //     "Popular",
    //   )),
    // );
    widgets.add(
      TmdbAttribution(
        type: Type.wide,
      ),
    );

    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
