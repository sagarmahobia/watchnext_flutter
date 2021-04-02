// To parse this JSON data, do
//
//     final people = peopleFromJson(jsonString);

import 'dart:convert';

People peopleFromJson(String str) => People.fromJson(json.decode(str));

List<Result> peopleForCredit(String str) {
  Map<String, dynamic> decode = json.decode(str);
  return List<Result>.from(decode["cast"].map((x) => Result.fromJson(x)));
}

class People {
  People({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  int page;
  List<Result> results;
  int totalResults;
  int totalPages;

  factory People.fromJson(Map<String, dynamic> json) => People(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );
}

class Result {
  Result({
    this.profilePath,
    this.adult,
    this.id,
    this.name,
    this.popularity,
  });

  String profilePath;
  bool adult;
  int id;
  String name;
  double popularity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        profilePath: json["profile_path"],
        adult: json["adult"],
        id: json["id"],
        name: json["name"],
        popularity: json["popularity"].toDouble(),
      );
}
