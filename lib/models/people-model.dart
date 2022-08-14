import 'package:json_annotation/json_annotation.dart';
import 'package:watchnext/models/credits_model.dart';

part 'people-model.g.dart';

@JsonSerializable(createToJson: false)
class People {
  People({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'results')
  final List<Cast>? results;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'total_results')
  final int? totalResults;

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);
}