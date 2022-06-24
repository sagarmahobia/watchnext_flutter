import 'package:flutter/material.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/views/seasons/season_card_view/season_card_view.dart';

class SeasonsSlider extends StatefulWidget {
  final List<Season>? seasons;
  final int tvId;

  const SeasonsSlider({Key? key, required this.seasons, required this.tvId}) : super(key: key);

  @override
  _SeasonsSliderState createState() => _SeasonsSliderState();
}

class _SeasonsSliderState extends State<SeasonsSlider> {
  _SeasonsSliderState();

  @override
  Widget build(BuildContext context) {
    if (widget.seasons == null) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 8.0,
                      ),
                      child: Text(
                        "Seasons",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 260,
            margin: EdgeInsets.only(top: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getSeasonCards(widget.seasons ?? []),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getSeasonCards(List<Season> cardModels) {
    List<Widget> showCards = [];

    for (Season model in cardModels) {
      showCards.add(
        Container(
          width: 135,
          child: SeasonCard(
            inputModel: model,
            tvId: widget.tvId
          ),
        ),
      );
    }
    return showCards;
  }
}
