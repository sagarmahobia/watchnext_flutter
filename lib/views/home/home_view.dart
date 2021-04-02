import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';

final testUrl = "trending/movie/week";

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            padding: const EdgeInsets.only(top: 32.0, bottom: 0),
            child: Text(
              "WatchNext",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );

    widgets.add(
      Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Card(
                  color: lightBackGround,
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                "Click Here To Explore More",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
      SliderInputModel(
        url: "movie/now_playing",
        sliderTitle: "Now Playing",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/upcoming",
        sliderTitle: "Now Playing",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/popular",
        sliderTitle: "Now Playing",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "movie/top_rated",
        sliderTitle: "Now Playing",
        pictureType: "movie",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/airing_today",
        sliderTitle: "Now Playing",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/on_the_air",
        sliderTitle: "Now Playing",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/popular",
        sliderTitle: "Now Playing",
        pictureType: "tv",
      ),
    );

    models.add(
      SliderInputModel(
        url: "tv/top_rated",
        sliderTitle: "Now Playing",
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
