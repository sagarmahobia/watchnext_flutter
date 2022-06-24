import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'movie-detail-models.g.dart';

MovieDetail movieDetailFromJson(String str) => MovieDetail.fromJson(json.decode(str));

@JsonSerializable()
class MovieDetail {
  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'belongs_to_collection')
  final BelongsToCollection? belongsToCollection;

  @JsonKey(name: 'budget')
  final int? budget;

  @JsonKey(name: 'genres')
  final List<Genre> genres;

  @JsonKey(name: 'homepage')
  final String? homepage;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'production_companies')
  final List<ProductionCompany> productionCompanies;

  @JsonKey(name: 'production_countries')
  final List<ProductionCountry> productionCountries;

  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;

  @JsonKey(name: 'revenue')
  final int? revenue;

  @JsonKey(name: 'runtime')
  final int? runtime;

  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage> spokenLanguages;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'tagline')
  final String? tagline;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'video')
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);
}

@JsonSerializable()
class BelongsToCollection {
  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
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
class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'logo_path')
  final String? logoPath;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'origin_country')
  final String? originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
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

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
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
