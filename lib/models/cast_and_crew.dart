import 'package:json_annotation/json_annotation.dart';
import 'package:watchnext/models/credits_model.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/models/verify_date.dart';

part 'cast_and_crew.g.dart';

@JsonSerializable(createToJson: false)
class CastAndCrew {
  CastAndCrew({
    required this.id,
    required this.cast,
    required this.crew,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'cast')
  final List<Cast>? cast;

  @JsonKey(name: 'crew')
  final List<Cast>? crew;

  factory CastAndCrew.fromJson(Map<String, dynamic> json) => _$CastAndCrewFromJson(json);
}

