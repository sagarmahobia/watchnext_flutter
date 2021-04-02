// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));

class Videos {
  Videos({
    this.id,
    this.results,
  });

  int id;
  List<Result> results;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["id"],
        results: List<Result>.from(
            json["results"]?.map((x) => Result.fromJson(x)) ?? []),
      );
}

class Result {
  Result({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        key: json["key"],
        name: json["name"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
      );
}
