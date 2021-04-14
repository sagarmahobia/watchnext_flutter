import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/detail/detail_page_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';
import 'package:watchnext/views/video_slider_view/video_slider_input_model.dart';
import 'package:watchnext/views/video_slider_view/video_slider_view.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String pictureType;

  const DetailPage({Key key, this.id, this.pictureType}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(this.id, this.pictureType);
}

class _DetailPageState extends State<DetailPage> {
  DetailPageBloc bloc;

  final int id;
  final String type;

  _DetailPageState(this.id, this.type);

  @override
  void initState() {
    super.initState();
    bloc = DetailPageBloc(this.type, this.id);
    bloc.add(LoadPageDetail());
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder(
              cubit: bloc,
              builder: (context, state) {
                if (state is DetailPageLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: lightBackGround,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "https://image.tmdb.org/t/p/original" +
                                      (state.stateModel.backdrop ?? ""),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      state.stateModel.poster != null
                                          ? 130
                                          : 16,
                                      16,
                                      16,
                                      28),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.stateModel.title,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              state.stateModel.year,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                state.stateModel.runtime,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          state.stateModel.genres,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(state.stateModel.vote +
                                            " (" +
                                            state.stateModel.voteCount +
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
                                top: 220,
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
                                ), // or optionaly wrap the child in FractionalTranslation
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getTextBanners(
                              state.stateModel.textBannersInputModels),
                        ),
                      ),
                    ],
                  );
                } else if (state is DetailPageError) {
                  //TODO height
                  return InkWell(
                    onTap: () {
                      bloc.add(LoadPageDetail());
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
            VideoSliderView(
              inputModel: VideoSliderInputModel(
                id,
                this.type,
              ),
            ),
            SliderView(
              inputModel: SliderInputModel(
                  url: this.type + "/" + this.id.toString() + "/similar",
                  sliderTitle: "Similar",
                  pictureType: this.type,
                  isEmbedded: true),
            ),
            SliderView(
              inputModel: SliderInputModel(
                  url:
                      this.type + "/" + this.id.toString() + "/recommendations",
                  sliderTitle: "Recommendation",
                  pictureType: this.type,
                  isEmbedded: true),
            ),
            // PersonSliderView(
            //   inputModel: PersonSliderInputModel(
            //     "movie/" + this.id.toString() + "/credits",
            //     "",
            //     isCredit: true,
            //   ),
            // )//TODO Person Slider View
          ],
        ),
      ),
    );
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
