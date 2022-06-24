import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cast_and_crew.g.dart';

CastAndCrew castAndCrewFromJson(String str) => CastAndCrew.fromJson(jsonDecode(str));

@JsonSerializable(createToJson: false)
class CastAndCrew {
  CastAndCrew({
    required this.id,
    required this.cast,
    required this.crew,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'cast')
  final List<Cast>? cast;

  @JsonKey(name: 'crew')
  final List<Cast>? crew;

  factory CastAndCrew.fromJson(Map<String, dynamic> json) => _$CastAndCrewFromJson(json);
}

@JsonSerializable(createToJson: false)
class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
    required this.knownFor,
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'gender')
  final int? gender;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'original_name')
  final String? originalName;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  @JsonKey(name: 'cast_id')
  final int? castId;

  @JsonKey(name: 'character')
  final String? character;

  @JsonKey(name: 'credit_id')
  final String? creditId;

  @JsonKey(name: 'order')
  final int? order;

  @JsonKey(name: 'department')
  final String? department;

  @JsonKey(name: 'job')
  final String? job;

  @JsonKey(name: 'known_for')
  List<KnownFor>? knownFor;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

@JsonSerializable(createToJson: false)
class KnownFor {
  KnownFor({
    required this.adult,
    required this.backdrop_path,
    required this.genre_ids,
    required this.id,
    required this.media_type,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count,
    required this.first_air_date,
    required this.name,
    required this.origin_country,
    required this.original_name,
  });

  final bool? adult;
  final String? backdrop_path;
  final List<int>? genre_ids;
  final int? id;
  final String? media_type;
  final String? original_language;
  final String? original_title;
  final String? overview;
  final String? poster_path;
  final DateTime? release_date;
  final String? title;
  final bool? video;
  final double? vote_average;
  final int? vote_count;
  final DateTime? first_air_date;
  final String? name;
  final List<String>? origin_country;
  final String? original_name;

  factory KnownFor.fromJson(Map<String, dynamic> json) => _$KnownForFromJson(json);
}
