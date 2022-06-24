import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'tv-detail-models.g.dart';

TvDetail tvDetailFromJson(String str) => TvDetail.fromJson(json.decode(str));

@JsonSerializable()
class TvDetail {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'created_by')
  final List<dynamic>? createdBy;

  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRunTime;

  @JsonKey(name: 'first_air_date')
  final DateTime? firstAirDate;

  @JsonKey(name: 'genres')
  final List<Genre>? genres;

  @JsonKey(name: 'homepage')
  final String? homepage;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'in_production')
  final bool? inProduction;

  @JsonKey(name: 'languages')
  final List<String>? languages;

  @JsonKey(name: 'last_air_date')
  final DateTime? lastAirDate;

  @JsonKey(name: 'last_episode_to_air')
  final LastEpisodeToAir? lastEpisodeToAir;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'next_episode_to_air')
  final dynamic nextEpisodeToAir;

  @JsonKey(name: 'networks')
  final List<Network>? networks;

  @JsonKey(name: 'number_of_episodes')
  final int? numberOfEpisodes;

  @JsonKey(name: 'number_of_seasons')
  final int? numberOfSeasons;

  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_name')
  final String? originalName;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'production_companies')
  final List<Network>? productionCompanies;

  @JsonKey(name: 'production_countries')
  final List<ProductionCountry>? productionCountries;

  @JsonKey(name: 'seasons')
  final List<Season>? seasons;

  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage>? spokenLanguages;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'tagline')
  final String? tagline;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  factory TvDetail.fromJson(Map<String, dynamic> json) => _$TvDetailFromJson(json);

}

@JsonSerializable()
class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

}

@JsonSerializable()
class LastEpisodeToAir {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
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

  @JsonKey(name: 'air_date')
  final DateTime? airDate;

  @JsonKey(name: 'episode_number')
  final int? episodeNumber;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'production_code')
  final String? productionCode;

  @JsonKey(name: 'runtime')
  final int? runtime;

  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  @JsonKey(name: 'still_path')
  final String? stillPath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);

}

@JsonSerializable()
class Network {
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'logo_path')
  final String? logoPath;

  @JsonKey(name: 'origin_country')
  final String? originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

}

@JsonSerializable()
class ProductionCountry {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;

  @JsonKey(name: 'name')
  final String? name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => _$ProductionCountryFromJson(json);

}

@JsonSerializable()
class Season {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @JsonKey(name: 'air_date')
  final DateTime? airDate;

  @JsonKey(name: 'episode_count')
  final int? episodeCount;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

}

@JsonSerializable()
class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  @JsonKey(name: 'english_name')
  final String? englishName;

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @JsonKey(name: 'name')
  final String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);

}
