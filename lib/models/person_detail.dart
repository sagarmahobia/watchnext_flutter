import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'person_detail.g.dart';

PersonDetail personDetailFromJson(String str) => PersonDetail.fromJson(json.decode(str));

@JsonSerializable()
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
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'also_known_as')
  final List<String>? alsoKnownAs;

  @JsonKey(name: 'biography')
  final String? biography;

  @JsonKey(name: 'birthday')
  final DateTime? birthday;

  @JsonKey(name: 'deathday')
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

  factory PersonDetail.fromJson(Map<String, dynamic> json) => _$PersonDetailFromJson(json);

}