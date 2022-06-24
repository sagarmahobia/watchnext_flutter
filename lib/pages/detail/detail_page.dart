import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/detail/detail_page_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/person_slider_view/person_slider_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_slider_view.dart';
import 'package:watchnext/views/seasons/seasons_view.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';
import 'package:watchnext/views/video_slider_view/video_slider_input_model.dart';
import 'package:watchnext/views/video_slider_view/video_slider_view.dart';
import 'package:watchnext/views/watch_providers/watch_providers_view.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is DetailPageLoaded) {
                  return Column(
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
                          children: getTextBanners(state.stateModel.textBannersInputModels),
                        ),
                      ),
                      buildCollection(state),
                      Visibility(
                        visible: widget.pictureType == "tv",
                        child: SeasonsSlider(
                          seasons: state.stateModel.seasons,
                          tvId: widget.id,
                        ),
                      )
                    ],
                  );
                } else if (state is DetailPageError) {
                  return InkWell(
                    onTap: () {
                      bloc.add(LoadPageDetail(widget.id, widget.pictureType));
                    },
                    child: Container(
                      height: 300,
                      child: Center(
                        child: Text("Something went wrong. Tap to try again."),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            NativeAdView(false),
            // WatchProvidersView(this.id),//todo
            VideoSliderView(
              inputModel: VideoSliderInputModel(
                widget.id,
                widget.pictureType,
              ),
            ),
            SliderView(
              inputModel: SliderInputModel(
                  url: widget.pictureType + "/" + widget.id.toString() + "/similar",
                  sliderTitle: "Similar",
                  pictureType: widget.pictureType,
                  isEmbedded: true),
            ),
            SliderView(
              inputModel: SliderInputModel(
                  url: widget.pictureType + "/" + widget.id.toString() + "/recommendations",
                  sliderTitle: "Recommendation",
                  pictureType: widget.pictureType,
                  isEmbedded: true),
            ),
            Container(
              height: 28,
            ),
            PersonSliderView(
              inputModel: PersonSliderInputModel(
                "movie/" + widget.id.toString() + "/credits",
                "",
                isCredit: true,
              ),
            ),
            Container(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCollection(DetailPageLoaded state) {
    if (widget.pictureType == "movie" && (state.stateModel.showCollection ?? false)) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w500/" + (state.stateModel.collectionImage ?? ""),
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
                Text(
                  "Part of the " + (state.stateModel.collectionName ?? "N/A"),
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0x99000000),
                  ),
                  onPressed: () {},
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
  }

  List<Widget> getTextBanners(
    List<TextBannerInputModel> textBannersInputModels,
  ) {
    return textBannersInputModels
        .map(
          (e) => TextBanner(title: e.title, value: e.value),
        )
        .toList();
  }
}
