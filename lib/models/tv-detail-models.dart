import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/models/verify_date.dart';

part 'tv-detail-models.g.dart';

TvDetail tvDetailFromJson(String str) => TvDetail.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
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
    required this.similar,
    required this.recommendations,
    required this.credits,
    required this.videos,
  });

  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'created_by')
  final List<CreatedBy>? createdBy;

  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRunTime;

  @JsonKey(name: 'first_air_date')
  final DateTime? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;

  @JsonKey(name: 'in_production')
  final bool? inProduction;
  final List<String>? languages;

  @JsonKey(name: 'last_air_date')
  final DateTime? lastAirDate;

  @JsonKey(name: 'last_episode_to_air')
  final TEpisodeToAir? lastEpisodeToAir;
  final String? name;

  @JsonKey(name: 'next_episode_to_air')
  final TEpisodeToAir? nextEpisodeToAir;
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
  final String? overview;
  final double? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'production_companies')
  final List<Network>? productionCompanies;

  @JsonKey(name: 'production_countries')
  final List<ProductionCountry>? productionCountries;
  final List<Season>? seasons;

  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final Recommendations? similar;
  final Recommendations? recommendations;
  final Credits? credits;
  final Videos? videos;

  factory TvDetail.fromJson(Map<String, dynamic> json) => _$TvDetailFromJson(json);

}

@JsonSerializable(createToJson: false)
class CreatedBy {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  final int? id;

  @JsonKey(name: 'credit_id')
  final String? creditId;
  final String? name;
  final int? gender;

  @JsonKey(name: 'profile_path')
  final dynamic profilePath;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

}



@JsonSerializable(createToJson: false)
class TEpisodeToAir {
  TEpisodeToAir({
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
  final int? id;
  final String? name;
  final String? overview;

  @JsonKey(name: 'production_code')
  final String? productionCode;
  final int? runtime;

  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  @JsonKey(name: 'still_path')
  final String? stillPath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => _$TEpisodeToAirFromJson(json);

}

@JsonSerializable(createToJson: false)
class Network {
  Network({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
    required this.logo,
  });

  final int? id;
  final String? name;

  @JsonKey(name: 'logo_path')
  final String? logoPath;

  @JsonKey(name: 'origin_country')
  final String? originCountry;
  final Logo? logo;

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

}

@JsonSerializable(createToJson: false)
class Logo {
  Logo({
    required this.path,
    required this.aspectRatio,
  });

  final String? path;

  @JsonKey(name: 'aspect_ratio')
  final double? aspectRatio;

  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);

}



@JsonSerializable(createToJson: false)
class Season {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.networks,
  });

  @JsonKey(name: 'air_date')
  final DateTime? airDate;

  @JsonKey(name: 'episode_count')
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'season_number')
  final int? seasonNumber;
  final List<Network>? networks;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

}



