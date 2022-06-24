// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_and_crew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastAndCrew _$CastAndCrewFromJson(Map<String, dynamic> json) => CastAndCrew(
      id: json['id'] as int?,
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      adult: json['adult'] as bool?,
      gender: json['gender'] as int?,
      id: json['id'] as int?,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profile_path'] as String?,
      castId: json['cast_id'] as int?,
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: json['order'] as int?,
      department: json['department'] as String?,
      job: json['job'] as String?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => KnownFor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

KnownFor _$KnownForFromJson(Map<String, dynamic> json) => KnownFor(
      adult: json['adult'] as bool?,
      backdrop_path: json['backdrop_path'] as String?,
      genre_ids:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      media_type: json['media_type'] as String?,
      original_language: json['original_language'] as String?,
      original_title: json['original_title'] as String?,
      overview: json['overview'] as String?,
      poster_path: json['poster_path'] as String?,
      release_date: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      vote_count: json['vote_count'] as int?,
      first_air_date: json['first_air_date'] == null
          ? null
          : DateTime.parse(json['first_air_date'] as String),
      name: json['name'] as String?,
      origin_country: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      original_name: json['original_name'] as String?,
    );
