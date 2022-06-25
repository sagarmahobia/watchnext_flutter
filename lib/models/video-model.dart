import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'video-model.g.dart';

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
class Videos {
  Videos({
    required this.id,
    required this.results,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'results')
  final List<Result>? results;

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);
}

@JsonSerializable(createToJson: false)
class Result {
  Result({
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

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'key')
  final String? key;

  @JsonKey(name: 'site')
  final String? site;

  @JsonKey(name: 'size')
  final int? size;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'official')
  final bool? official;

  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  @JsonKey(name: 'id')
  final String? id;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
