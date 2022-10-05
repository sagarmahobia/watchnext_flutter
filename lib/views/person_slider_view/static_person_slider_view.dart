import 'package:flutter/material.dart';
import 'package:watchnext/models/credits_model.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_view.dart';

import 'person_card_view/person_card_input_model.dart';

class StaticPersonSliderView extends StatelessWidget {
  final List<Cast>? cast;
  final List<Cast>? crew;

  final String? titleCast;
  final String? titleCrew;

  const StaticPersonSliderView(
      {Key? key, required this.cast, required this.crew, this.titleCast, this.titleCrew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cast != null || crew != null,
      child: Column(
        children: [
          Visibility(
            visible: cast != null && (cast?.isNotEmpty ?? false),
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
                      titleCast ?? "Cast",
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
                        children: cast
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
            visible: crew != null && (crew?.isNotEmpty ?? false),
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
                      titleCrew ?? "Crew",
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
                        children: crew
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
