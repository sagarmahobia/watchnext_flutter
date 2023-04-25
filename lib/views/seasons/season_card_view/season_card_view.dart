import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/pages/seaons/season_detail.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/views/seasons/season_card_view/season_card_input_model.dart';

class SeasonCard extends StatelessWidget {
  // late SeasonCardInputModel inputModel;
  final Season inputModel;
  final int tvId;

  SeasonCard({
    Key? key,
    required this.inputModel,
    required this.tvId,
  }) : super(key: key) {
    // this.inputModel = SeasonCardInputModel(
    //     inputModel.id ?? 0,
    //     "https://image.tmdb.org/t/p/w185" + (inputModel.posterPath ?? ""),
    //     inputModel.name ?? "N/A",
    //     inputModel.episodeCount ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: lightBackGround,
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeasonDetail(
                  tvId: this.tvId,
                  seasonNumber: inputModel.seasonNumber ?? 0,
                  name: inputModel.name ?? ""),
            ),
          );
        },
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),

                    // child: FadeInImage.memoryNetwork(
                    //   placeholder: kTransparentImage,
                    //   imageErrorBuilder: (context, error, stackTrace) {
                    //     return Container(
                    //       height: 180,
                    //       child: Center(
                    //         child: Icon(
                    //           Icons.broken_image_rounded,
                    //           size: 50,
                    //           color: Colors.white24,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   image: "https://image.tmdb.org/t/p/w185" + (this.inputModel.posterPath ?? ""),
                    //   fit: BoxFit.fitWidth,
                    // ),

                    child: getImage(
                      "https://image.tmdb.org/t/p/w185" + (this.inputModel.posterPath ?? ""),
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      height: 190,
                    ),//todo height issue
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    constraints: BoxConstraints(
                      minHeight: 56,
                    ),
                    child: Text(
                      inputModel.name ?? "N/A",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 16,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xBB000000),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 4,
                    top: 6,
                    bottom: 6,
                  ),
                  child: Text(
                    (this.inputModel.episodeCount ?? 0).toString() + " Episodes",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
