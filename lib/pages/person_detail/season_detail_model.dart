import 'dart:convert';

import 'package:watchnext/models/cast_and_crew.dart';

SeasonDetailModel seasonDetailFromJson(String str) => SeasonDetailModel.fromJson(jsonDecode(str));

class SeasonDetailModel {
  SeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? id;
  final DateTime? airDate;
  final List<Episode> episodes;
  final String? name;
  final String? overview;
  final int? seasonDetailModelId;
  final String? posterPath;
  final int? seasonNumber;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) {
    return SeasonDetailModel(
      id: json["_id"],
      airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
      episodes: json["episodes"] == null
          ? []
          : List<Episode>.from(json["episodes"]!.map((x) => Episode.fromJson(x))),
      name: json["name"],
      overview: json["overview"],
      seasonDetailModelId: json["id"],
      posterPath: json["poster_path"],
      seasonNumber: json["season_number"],
    );
  }
}

class Episode {
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final DateTime? airDate;
  final int? episodeNumber;
  final List<Cast> crew;
  final List<Cast> guestStars;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final String? stillPath;
  final num? voteAverage;
  final int? voteCount;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
      episodeNumber: json["episode_number"],
      crew: json["crew"] == null ? [] : List<Cast>.from(json["crew"]!.map((x) => Cast.fromJson(x))),
      guestStars: json["guest_stars"] == null
          ? []
          : List<Cast>.from(json["guest_stars"]!.map((x) => Cast.fromJson(x))),
      id: json["id"],
      name: json["name"],
      overview: json["overview"],
      productionCode: json["production_code"],
      runtime: json["runtime"],
      seasonNumber: json["season_number"],
      stillPath: json["still_path"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }
}
