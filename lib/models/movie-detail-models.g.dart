// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie-detail-models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => MovieDetail(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      belongsToCollection: json['belongs_to_collection'] == null
          ? null
          : BelongsToCollection.fromJson(
              json['belongs_to_collection'] as Map<String, dynamic>),
      budget: (json['budget'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      id: (json['id'] as num?)?.toInt(),
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      releaseDate: verify_date(json, 'release_date') == null
          ? null
          : DateTime.parse(verify_date(json, 'release_date') as String),
      revenue: (json['revenue'] as num?)?.toInt(),
      runtime: (json['runtime'] as num?)?.toInt(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      similar: json['similar'] == null
          ? null
          : Recommendations.fromJson(json['similar'] as Map<String, dynamic>),
      recommendations: json['recommendations'] == null
          ? null
          : Recommendations.fromJson(
              json['recommendations'] as Map<String, dynamic>),
      credits: json['credits'] == null
          ? null
          : Credits.fromJson(json['credits'] as Map<String, dynamic>),
      videos: json['videos'] == null
          ? null
          : Videos.fromJson(json['videos'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
    );

BelongsToCollection _$BelongsToCollectionFromJson(Map<String, dynamic> json) =>
    BelongsToCollection(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );

Credits _$CreditsFromJson(Map<String, dynamic> json) => Credits(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: (json['id'] as num?)?.toInt(),
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
    );

ProductionCountry _$ProductionCountryFromJson(Map<String, dynamic> json) =>
    ProductionCountry(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );

Recommendations _$RecommendationsFromJson(Map<String, dynamic> json) =>
    Recommendations(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Show.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      totalResults: (json['total_results'] as num?)?.toInt(),
    );

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['english_name'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => VideosResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

VideosResult _$VideosResultFromJson(Map<String, dynamic> json) => VideosResult(
      iso6391: json['iso_639_1'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
      key: json['key'] as String?,
      site: json['site'] as String?,
      size: (json['size'] as num?)?.toInt(),
      type: json['type'] as String?,
      official: json['official'] as bool?,
      publishedAt: verify_date(json, 'published_at') == null
          ? null
          : DateTime.parse(verify_date(json, 'published_at') as String),
      id: json['id'] as String?,
    );

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      backdrops: (json['backdrops'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      logos: (json['logos'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toInt(),
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
    );
