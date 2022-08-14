import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/collection_detail/collection_detail.dart';
import 'package:watchnext/pages/detail/detail_page_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/person_slider_view/static_person_slider_view.dart';
import 'package:watchnext/views/seasons/seasons_view.dart';
import 'package:watchnext/views/sliderview/sliderview_static.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';
import 'package:watchnext/views/video_slider_view/video_card_view/video_card_input_model.dart';
import 'package:watchnext/views/video_slider_view/video_slider_view.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String pictureType;

  const DetailPage({Key? key, required this.id, required this.pictureType}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailPageBloc bloc = DetailPageBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(LoadPageDetail(widget.id, widget.pictureType));
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 1,
        title: Text("Detail"),
      ),
      body: Container(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is DetailPageLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: lightBackGround,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 900),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original" +
                                        (state.stateModel.backdrop ?? ""),
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, xstackTrace) {
                                      return Container(
                                        height: 200,
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image_outlined,
                                            size: 75,
                                            color: Colors.white24,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    state.stateModel.poster != null ? 130 : 16, 16, 16, 28),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.stateModel.title ?? "N/A",
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            state.stateModel.year ?? "N/A",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              state.stateModel.runtime ?? "N/A",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        state.stateModel.genres ?? "N/A",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(state.stateModel.vote ??
                                          "0" +
                                              " (" +
                                              (state.stateModel.voteCount ?? "0") +
                                              " votes)"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: state.stateModel.poster != null,
                            child: Positioned(
                              bottom: 12,
                              left: 12,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/original" +
                                    (state.stateModel.poster ?? ""),
                                fit: BoxFit.fitHeight,
                                height: 150,
                                width: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    width: 100,
                                    child: Center(
                                      child: Icon(
                                        Icons.broken_image_outlined,
                                        size: 50,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (state.stateModel.textBannersInputModels)
                            .map(
                              (e) => TextBanner(title: e.title, value: e.value),
                        )
                            .toList(),
                      ),
                    ),
                    NativeAdView(false),
                    Builder(builder: (context) {
                      if (widget.pictureType == "movie" &&
                          (state.stateModel.showCollection ?? false)) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                "https://image.tmdb.org/t/p/w500/" +
                                    (state.stateModel.collectionImage ?? ""),
                                width: double.infinity,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, xStackTrace) {
                                  return Container(
                                    height: 200,
                                    child: Center(
                                      child: Icon(
                                        Icons.broken_image_outlined,
                                        size: 75,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Column(
                                children: [
                                  Visibility(
                                    visible: state.stateModel.collectionName != null,
                                    child: Text(
                                      "Part of the " + (state.stateModel.collectionName ?? "N/A"),
                                      style: TextStyle(fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0x99000000),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CollectionDetail(
                                                id: state.stateModel.collectionId ?? 0,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "View Collection",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                    Visibility(
                      visible: widget.pictureType == "tv",
                      child: SeasonsSlider(
                        seasons: state.stateModel.seasons,
                        tvId: widget.id,
                      ),
                    ),
                    VideoSliderView(
                      cardModels: state.stateModel.videos?.map((e) {
                        var image =
                            "https://img.youtube.com/vi/" + (e.key ?? "") + "/mqdefault.jpg";
                        var url = "https://www.youtube.com/watch?v=" + (e.key ?? "");
                        return VideoCardInputModel(e.name ?? "", e.type ?? "", image, url);
                      }).toList() ??
                          [],
                    ),
                    StaticShowSlider(
                      type: widget.pictureType,
                      title: "Similar",
                      shows: state.stateModel.similar,
                      url: widget.pictureType + "/" + widget.id.toString() + "/similar",
                    ),
                    StaticShowSlider(
                      type: widget.pictureType,
                      title: "Recommended",
                      shows: state.stateModel.recommendations,
                      url: widget.pictureType + "/" + widget.id.toString() + "/recommendations",
                    ),
                    StaticPersonSliderView(credits: state.stateModel.credits),
                  ],
                ),
              );
            } else if (state is DetailPageError) {
              return InkWell(
                onTap: () {
                  bloc.add(LoadPageDetail(widget.id, widget.pictureType));
                },
                child: Center(
                  child: Text("Something went wrong. Tap to try again."),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
/*
class MyScaffold extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget body;

  const MyScaffold({
    Key? key,
    this.appBar,
    this.backgroundColor,
    required this.body,
  }) : super(key: key);

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
  new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  bool _show = true;
  double bottomBarHeight = 75; // set bottom bar height
  double _bottomBarOffset = 0;

  @override
  void initState() {
    super.initState();
    myScroll();
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _showAppbar
            ? widget.appBar
            : PreferredSize(
          child: Container(),
          preferredSize: Size(0.0, 0.0),
        ),
        backgroundColor: widget.backgroundColor,
        body: SingleChildScrollView(
        controller: _scrollBottomBarController
        , child: widget.body),);
  }
}*/
