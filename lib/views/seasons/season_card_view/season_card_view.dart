import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/seasons/season_card_view/season_card_input_model.dart';

class SeasonCard extends StatelessWidget {
  SeasonCardInputModel inputModel;

  SeasonCard({
    Key key,
    Season inputModel,
  }) : super(key: key) {
    this.inputModel = SeasonCardInputModel(
        inputModel.id,
        "https://image.tmdb.org/t/p/w185" + inputModel.posterPath,
          inputModel.name ,
        inputModel.episodeCount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightBackGround,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailPage(
          //       id: inputModel.id,
          //       pictureType: inputModel.type,
          //     ),
          //   ),
          // );
        },
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 50,
                            color: Colors.white24,
                          ),
                        ),
                      );
                    },
                    image: this.inputModel.imageUrl,
                    fit: BoxFit.fitWidth,
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
                      inputModel.title,
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
                    this.inputModel.episodes.toString() + " Episodes",
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
