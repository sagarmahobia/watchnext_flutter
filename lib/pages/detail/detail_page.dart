import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watchnext/pages/collection_detail/collection_detail.dart';
import 'package:watchnext/pages/detail/detail_page_bloc.dart';
import 'package:watchnext/pages/detail/homepagew_widget.dart';
import 'package:watchnext/pages/image_viewer/image_viewer.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/attribute/tmdb_attribute.dart';
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
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(LoadPageDetail(widget.id, widget.pictureType));
    });
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is DetailPageLoaded) {
              var get5backdrops = state.stateModel.get5Backdrops();
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                              Stack(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                        // height: 400.0,
                                        viewportFraction: 1,
                                        autoPlay: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        }),
                                    items: get5backdrops.map((item) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context, rootNavigator: true).push(
                                            MaterialPageRoute(
                                              builder: (context) => ImageViewer(
                                                state.stateModel.getAllBackdropsInHQ(),
                                                currentIndex,
                                              ),
                                            ),
                                          );
                                        },
                                        child: getImage(
                                          item ?? '',
                                          fit: BoxFit.contain,
                                          // height: 400,
                                          width: double.infinity,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Positioned(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: get5backdrops.map(
                                        (e) {
                                          int index = get5backdrops.indexOf(e);
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 5,
                                              color: currentIndex == index
                                                  ? Colors.red
                                                  : Colors.black54,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    bottom: 20,
                                    right: 0,
                                    left: 0,
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    state.stateModel.poster != null ? 130 : 16, 16, 16, 24),
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
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text((double.parse(state.stateModel.vote??"0.0").toStringAsFixed(2)) +
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                      builder: (context) => ImageViewer(
                                        state.stateModel.getAllPostersInHQ(),
                                        0,
                                      ),
                                    ),
                                  );
                                },
                                child: getImage(
                                  getImageUrlPosterLQ(state.stateModel.poster ?? ""),
                                  fit: BoxFit.fitHeight,
                                  height: 150,
                                  width: 100,
                                ),
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
                    HomepageWidget(homepage: state.stateModel.homepage,),
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
                                height: 200,
                                errorBuilder: (context, error, xStackTrace) {
                                  return Container(
                                    height: 200,
                                    child: Center(
                                      child: Icon(
                                        Icons.broken_image_rounded,
                                        size: 75,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: ColoredBox(color: Colors.black.withOpacity(0.4)),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CollectionDetail(
                                        id: state.stateModel.collectionId ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
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
                                            builder: (context) => CollectionDetail(
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
                                ),
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

                    Builder(builder: (context) {
                      var imageBuilders = state.stateModel.getImagesBuilder();

                      if (imageBuilders.isNotEmpty) {
                        return Container(
                            margin: EdgeInsets.only(top: 16.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 16.0, right: 8.0, bottom: 8.0),
                                    child: Text(
                                      "Media",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: imageBuilders
                                          .map(
                                            (e) => Container(
                                              margin: EdgeInsets.all(4),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context, rootNavigator: true).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => ImageViewer(
                                                        e["images"] as List<String>,
                                                        0,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Stack(
                                                  alignment: Alignment.bottomCenter,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: lightBackGround,
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(4.0),
                                                        child: getImage((e["image"] as String),
                                                            height: e["height"] as double,
                                                            width:
                                                                (e["width"] as double).toDouble(),
                                                            fit: BoxFit.fitHeight),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: Container(
                                                        width: e["width"] as double,
                                                        padding: EdgeInsets.all(8.0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(4),
                                                              bottomRight: Radius.circular(4)),
                                                          gradient: LinearGradient(
                                                              colors: [
                                                                Colors.black.withOpacity(0.5),
                                                                Colors.black.withOpacity(.4)
                                                              ],
                                                              begin: Alignment.bottomCenter,
                                                              end: Alignment.topCenter,
                                                              stops: [0.0, 1.0],
                                                              tileMode: TileMode.clamp),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            e["title"] as String,
                                                            textAlign: TextAlign.start,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      } else {
                        return SizedBox();
                      }
                    }),
                    NativeAdView(false),

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
                    StaticPersonSliderView(
                      cast: state.stateModel.credits?.cast,
                      crew: state.stateModel.credits?.crew,
                    ),
                    NativeAdView(false),
                    TmdbAttribution(type: Type.wide),

                    Container(
                      height: 30,
                    )
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
            }

            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                child: Shimmer.fromColors(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 8),
                              height: 150,
                              width: 90,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8).copyWith(right: 156),
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8).copyWith(right: 156),
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8).copyWith(right: 156),
                                    height: 20,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 16),
                          color: Colors.white,
                          width: 120,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 0),
                          color: Colors.white,
                          width: double.infinity,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 16),
                          color: Colors.white,
                          width: 120,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 0),
                          color: Colors.white,
                          width: double.infinity,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 16),
                          color: Colors.white,
                          width: 120,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 0),
                          color: Colors.white,
                          width: double.infinity,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 16),
                          color: Colors.white,
                          width: 120,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 0),
                          color: Colors.white,
                          width: double.infinity,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 16),
                          color: Colors.white,
                          width: 120,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 0),
                          color: Colors.white,
                          width: double.infinity,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 16),
                          color: Colors.white,
                          width: 120,
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.all(8).copyWith(top: 0),
                          color: Colors.white,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    baseColor: darkBackGround,
                    highlightColor: lightBackGround),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
