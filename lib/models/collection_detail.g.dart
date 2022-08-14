// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionDetailModel _$CollectionDetailModelFromJson(
        Map<String, dynamic> json) =>
    CollectionDetailModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => Show.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Part _$PartFromJson(Map<String, dynamic> json) => Part(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      title: json['title'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: verify_date(json, 'release_date') == null
          ? null
          : DateTime.parse(verify_date(json, 'release_date') as String),
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );
