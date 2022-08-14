import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/models/verify_date.dart';

import 'credits_model.dart';

part 'movie-detail-models.g.dart';

MovieDetail movieDetailFromJson(String str) => MovieDetail.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
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
    required this.similar,
    required this.recommendations,
    required this.credits,
    required this.videos,
  });

  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'belongs_to_collection')
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;

  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final double? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'production_companies')
  final List<ProductionCompany>? productionCompanies;

  @JsonKey(name: 'production_countries')
  final List<ProductionCountry>? productionCountries;

  @JsonKey(name: 'release_date', readValue: verify_date)
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;

  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final Recommendations? similar;
  final Recommendations? recommendations;
  final Credits? credits;
  final Videos? videos;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);
}

@JsonSerializable(createToJson: false)
class BelongsToCollection {
  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  final int? id;
  final String? name;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
}

@JsonSerializable(createToJson: false)
class Credits {
  Credits({
    required this.cast,
    required this.crew,
  });

  final List<Cast>? cast;
  final List<Cast>? crew;

  factory Credits.fromJson(Map<String, dynamic> json) => _$CreditsFromJson(json);
}

@JsonSerializable(createToJson: false)
class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int? id;

  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String? name;

  @JsonKey(name: 'origin_country')
  final String? originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProductionCountry {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  final String? name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
}

@JsonSerializable(createToJson: false)
class Recommendations {
  Recommendations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int? page;
  final List<Show>? results;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'total_results')
  final int? totalResults;

  factory Recommendations.fromJson(Map<String, dynamic> json) => _$RecommendationsFromJson(json);
}

@JsonSerializable(createToJson: false)
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
  final String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);
}

@JsonSerializable(createToJson: false)
class Videos {
  Videos({
    required this.results,
  });

  final List<VideosResult>? results;

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);
}

@JsonSerializable(createToJson: false)
class VideosResult {
  VideosResult({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;

  @JsonKey(name: 'published_at', readValue: verify_date)
  final DateTime? publishedAt;
  final String? id;

  factory VideosResult.fromJson(Map<String, dynamic> json) => _$VideosResultFromJson(json);
}
