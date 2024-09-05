// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetail _$PersonDetailFromJson(Map<String, dynamic> json) => PersonDetail(
      adult: json['adult'] as bool?,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      biography: json['biography'] as String?,
      birthday: verify_date(json, 'birthday') == null
          ? null
          : DateTime.parse(verify_date(json, 'birthday') as String),
      deathday: verify_date(json, 'deathday') == null
          ? null
          : DateTime.parse(verify_date(json, 'deathday') as String),
      gender: (json['gender'] as num?)?.toInt(),
      homepage: json['homepage'],
      id: (json['id'] as num?)?.toInt(),
      imdbId: json['imdb_id'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profile_path'] as String?,
      movieCredits: json['movie_credits'] == null
          ? null
          : MovieCredits.fromJson(
              json['movie_credits'] as Map<String, dynamic>),
      tvCredits: json['tv_credits'] == null
          ? null
          : MovieCredits.fromJson(json['tv_credits'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
    );

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toInt(),
      iso6391: json['iso_639_1'],
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
    );

MovieCredits _$MovieCreditsFromJson(Map<String, dynamic> json) => MovieCredits(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Show.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => Show.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
