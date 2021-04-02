import 'dart:convert';

ListResponse listResponseFromJson(String str) =>
    ListResponse.fromJson(json.decode(str));

class ListResponse {
  ListResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<ResultItem> results;
  int totalPages;
  int totalResults;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        page: json["page"],
        results: List<ResultItem>.from(
            json["results"].map((x) => ResultItem.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class ResultItem {
  ResultItem({
    this.id,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.voteCount,
    this.name,
  });

  int id;
  String posterPath;
  String title;
  double voteAverage;
  int voteCount;
  String name;

  factory ResultItem.fromJson(Map<String, dynamic> json) => ResultItem(
        id: json["id"],
        posterPath: json["poster_path"],
        title: json["title"] == null ? null : json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        name: json["name"] == null ? null : json["name"],
      );
}
