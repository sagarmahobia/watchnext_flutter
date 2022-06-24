import 'dart:convert';

import 'package:watchnext/models/cast_and_crew.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people-model.g.dart';

People peopleFromJson(String str) => People.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
class People {
  People({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'results')
  final List<Cast>? results;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'total_results')
  final int? totalResults;

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

}


@JsonSerializable(createToJson: false)
class KnownFor {
  KnownFor({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.name,
    required this.originCountry,
    required this.originalName,
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'media_type')
  final String? mediaType;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'video')
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @JsonKey(name: 'first_air_date')
  final DateTime? firstAirDate;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  @JsonKey(name: 'original_name')
  final String? originalName;

  factory KnownFor.fromJson(Map<String, dynamic> json) => _$KnownForFromJson(json);

}
