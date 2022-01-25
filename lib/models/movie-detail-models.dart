// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MovieDetail movieDetailFromJson(String str) =>
    MovieDetail.fromJson(json.decode(str));

class MovieDetail {
  MovieDetail({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool adult;
  String backdropPath;
  Collection belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection:
        ( json["belongs_to_collection"]!=null? Collection.fromJson(json["belongs_to_collection"]):null) ,
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"],
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int id;
  String logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );
}

class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );
}

class SpokenLanguage {
  SpokenLanguage({
    this.iso6391,
    this.name,
  });

  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        iso6391: json["iso_639_1"],
        name: json["name"],
      );
}

class Collection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  Collection(this.id, this.name, this.posterPath, this.backdropPath);

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        json['id'],
        json['name'],
        json['poster_path'],
        json['backdrop_path'],
      );
}
