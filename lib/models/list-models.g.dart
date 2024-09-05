// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list-models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
      dates: json['dates'] == null
          ? null
          : Dates.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Show.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      totalResults: (json['total_results'] as num?)?.toInt(),
    );

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
      maximum: verify_date(json, 'maximum') == null
          ? null
          : DateTime.parse(verify_date(json, 'maximum') as String),
      minimum: verify_date(json, 'minimum') == null
          ? null
          : DateTime.parse(verify_date(json, 'minimum') as String),
    );

Show _$ShowFromJson(Map<String, dynamic> json) => Show(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num?)?.toInt(),
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: verify_date(json, 'release_date') == null
          ? null
          : DateTime.parse(verify_date(json, 'release_date') as String),
      title: json['title'] as String?,
      name: json['name'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      character: json['character'] as String?,
    );
