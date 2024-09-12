// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos(
      id: (json['id'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
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
