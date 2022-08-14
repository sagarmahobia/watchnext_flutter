import 'package:json_annotation/json_annotation.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/models/verify_date.dart';

part 'credits_model.g.dart';



@JsonSerializable(createToJson: false)
class CreditsModel {
  CreditsModel({
    required this.cast,
    required this.crew,
    required this.id,
  });

  @JsonKey(name: 'cast')
  final List<Cast>? cast;

  @JsonKey(name: 'crew')
  final List<Cast>? crew;

  @JsonKey(name: 'id')
  final int? id;

  factory CreditsModel.fromJson(Map<String, dynamic> json) => _$CreditsModelFromJson(json);
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
    required this.releaseDate,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
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

  @JsonKey(name: 'release_date', readValue: verify_date)
  final DateTime? releaseDate;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @JsonKey(name: 'video')
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
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

  @JsonKey(name: 'release_date', readValue: verify_date)
  final DateTime? releaseDate;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'video')
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @JsonKey(name: 'first_air_date', readValue: verify_date)
  final DateTime? firstAirDate;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  @JsonKey(name: 'original_name')
  final String? originalName;

  factory KnownFor.fromJson(Map<String, dynamic> json) => _$KnownForFromJson(json);
}