import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/models/verify_date.dart';

part 'person_detail.g.dart';

PersonDetail personDetailFromJson(String str) => PersonDetail.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
class PersonDetail {
  PersonDetail({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
    required this.movieCredits,
    required this.tvCredits
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'also_known_as')
  final List<String>? alsoKnownAs;

  @JsonKey(name: 'biography')
  final String? biography;

  @JsonKey(name: 'birthday', readValue: verify_date)
  final DateTime? birthday;

  @JsonKey(name: 'deathday',  readValue: verify_date)
  final DateTime? deathday;

  @JsonKey(name: 'gender')
  final int? gender;

  @JsonKey(name: 'homepage')
  final dynamic homepage;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  @JsonKey(name: 'movie_credits')
  final MovieCredits? movieCredits;

  @JsonKey(name: 'tv_credits')
  final MovieCredits? tvCredits;

  factory PersonDetail.fromJson(Map<String, dynamic> json) => _$PersonDetailFromJson(json);
}

@JsonSerializable(createToJson: false)
class MovieCredits {
  MovieCredits({
    required this.cast,
    required this.crew,
  });

  @JsonKey(name: "cast")
  final List<Show>? cast;

  @JsonKey(name: "crew")
  final List<Show>? crew;

  factory MovieCredits.fromJson(Map<String, dynamic> json) => _$MovieCreditsFromJson(json);
}
