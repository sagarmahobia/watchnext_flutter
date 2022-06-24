import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/seaons/season_detail_bloc.dart';
import 'package:watchnext/res/app_values.dart';

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
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SeasonDetailsLoaded) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: (state.seasonDetail.episodes)
                      .map(
                        (e) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: getImage(getImageUrl(e.stillPath.toString()),
                                  width: 180, height: 90),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name.toString(),
                                    maxLines: 3,
                                  ),
                                  Text("Episode " + e.episodeNumber.toString()),
                                  Text(e.airDate.toString()),//todo episode detail
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
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
