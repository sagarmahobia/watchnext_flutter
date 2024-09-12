// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_and_crew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastAndCrew _$CastAndCrewFromJson(Map<String, dynamic> json) => CastAndCrew(
      id: (json['id'] as num?)?.toInt(),
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
