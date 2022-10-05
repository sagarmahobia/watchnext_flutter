import 'package:flutter/material.dart';
import 'package:watchnext/models/cast_and_crew.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/pages/person_detail/season_detail_model.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_slider_view_bloc.dart';
import 'package:watchnext/views/person_slider_view/static_person_slider_view.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class EpisodeDetail extends StatefulWidget {
  final Episode episode;

  const EpisodeDetail(this.episode, {Key? key}) : super(key: key);

  @override
  State<EpisodeDetail> createState() => _EpisodeDetailState();
}

class _EpisodeDetailState extends State<EpisodeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text(widget.episode.name ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getImage(
              getImageUrl(widget.episode.stillPath.toString()),
              width: double.infinity,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.episode.name ?? "N/A",
                    style: TextStyle(fontSize: 24),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.movie_filter_outlined,
                          size: 14,
                        ),
                        Text(" Season " + (widget.episode.seasonNumber ?? 0).toString()),
                        Text(" - Episode " + (widget.episode.episodeNumber ?? 0).toString()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 14,
                        ),
                        Text(" " + (widget.episode.voteAverage?.toString() ?? "0")),
                        Text(" (" + (widget.episode.voteCount?.toString() ?? "0") + ")"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextBanner(title: "Overview", value: widget.episode.overview),
            TextBanner(title: "Air Date", value: DateUtil.getPrettyDate(widget.episode.airDate)),
            StaticPersonSliderView(
              cast: widget.episode.crew,
              crew: widget.episode.guestStars,
              titleCast: "Crew",
              titleCrew: "Guest Stars",
            )
          ],
        ),
      ),
    );
  }
}
