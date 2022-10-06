import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/episode_detail/episode_detail.dart';
import 'package:watchnext/pages/seaons/season_detail_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class SeasonDetail extends StatefulWidget {
  final int tvId;
  final int seasonNumber;

  final String name;

  const SeasonDetail({Key? key, required this.tvId, required this.seasonNumber, required this.name})
      : super(key: key);

  @override
  State<SeasonDetail> createState() => _SeasonDetailState();
}

class _SeasonDetailState extends State<SeasonDetail> {
  var bloc = SeasonDetailBloc();

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    bloc.add(LoadSeasonDetail(widget.tvId, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          widget.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: backGroundColor,
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SeasonDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: lightBackGround,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getImage(
                            getImageUrl(state.seasonDetail.posterPath?.toString() ?? ""),
                            width: 120,
                            height: 180,
                          ),
                        ),
                        Container(
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.seasonDetail.name ?? "N/A",
                                style: TextStyle(fontSize: 24),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(DateUtil.getPrettyDate(state.seasonDetail.airDate)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    "Season " + (state.seasonDetail.seasonNumber ?? 0).toString()),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  TextBanner(title: "Overview", value: state.seasonDetail.overview),

                  NativeAdView(true),
                  Container(
                    height: 6,
                  ),
                  Column(
                    children: (state.seasonDetail.episodes)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                            child: Card(
                              color: lightBackGround,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EpisodeDetail(e),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    getImage(getImageUrl(e.stillPath.toString()),
                                        width: 180, height: 90),
                                    Expanded(
                                      child: Container(
                                        height: 90,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.name.toString(),
                                              maxLines: 3,
                                            ),
                                            Text("Episode " + e.episodeNumber.toString()),
                                            Text(DateUtil.getPrettyDate(e.airDate)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                ],
              ),
            );
          } else if (state is SeasonDetailsLoadError) {
            return Center(
              child: InkWell(
                onTap: () {
                  load();
                },
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text("Something went wrong. Tap to reload"),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
