import 'package:flutter/material.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_view.dart';

import 'person_card_view/person_card_input_model.dart';

class StaticPersonSliderView extends StatelessWidget {
  final Credits? credits;

  const StaticPersonSliderView({Key? key, required this.credits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: credits != null,
      child: Column(
        children: [
          Visibility(
            visible: credits?.cast != null && (credits?.cast?.isNotEmpty ?? false),
            child: Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                    ),
                    child: Text(
                      "Cast",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 240,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: credits?.cast
                                ?.map((e) => Container(
                                      width: 130,
                                      padding: EdgeInsets.only(left: 4, right: 4),
                                      child: PersonCardView(
                                        inputModel: PersonCardInputModel(
                                            e.id ?? 0,
                                            e.name ?? "",
                                            "https://image.tmdb.org/t/p/w342" +
                                                (e.profilePath ?? "")),
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: credits?.crew != null && (credits?.crew?.isNotEmpty ?? false),
            child: Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                    ),
                    child: Text(
                      "Crew",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 235,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: credits?.crew
                                ?.map((e) => Container(
                                      width: 130,
                                      padding: EdgeInsets.only(left: 4, right: 4),
                                      child: PersonCardView(
                                        inputModel: PersonCardInputModel(
                                            e.id ?? 0,
                                            e.name ?? "",
                                            "https://image.tmdb.org/t/p/w342" +
                                                (e.profilePath ?? "")),
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
