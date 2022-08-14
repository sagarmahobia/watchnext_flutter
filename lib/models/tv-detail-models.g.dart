// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv-detail-models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvDetail _$TvDetailFromJson(Map<String, dynamic> json) => TvDetail(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      createdBy: (json['created_by'] as List<dynamic>?)
          ?.map((e) => CreatedBy.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      firstAirDate: json['first_air_date'] == null
          ? null
          : DateTime.parse(json['first_air_date'] as String),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int?,
      inProduction: json['in_production'] as bool?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastAirDate: json['last_air_date'] == null
          ? null
          : DateTime.parse(json['last_air_date'] as String),
      lastEpisodeToAir: json['last_episode_to_air'] == null
          ? null
          : TEpisodeToAir.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>),
      name: json['name'] as String?,
      nextEpisodeToAir: json['next_episode_to_air'] == null
          ? null
          : TEpisodeToAir.fromJson(
              json['next_episode_to_air'] as Map<String, dynamic>),
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfEpisodes: json['number_of_episodes'] as int?,
      numberOfSeasons: json['number_of_seasons'] as int?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      type: json['type'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      similar: json['similar'] == null
          ? null
          : Recommendations.fromJson(json['similar'] as Map<String, dynamic>),
      recommendations: json['recommendations'] == null
          ? null
          : Recommendations.fromJson(
              json['recommendations'] as Map<String, dynamic>),
      credits: json['credits'] == null
          ? null
          : Credits.fromJson(json['credits'] as Map<String, dynamic>),
      videos: json['videos'] == null
          ? null
          : Videos.fromJson(json['videos'] as Map<String, dynamic>),
    );

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      id: json['id'] as int?,
      creditId: json['credit_id'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as int?,
      profilePath: json['profile_path'],
    );

TEpisodeToAir _$TEpisodeToAirFromJson(Map<String, dynamic> json) =>
    TEpisodeToAir(
      airDate: json['air_date'] == null
          ? null
          : DateTime.parse(json['air_date'] as String),
      episodeNumber: json['episode_number'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      productionCode: json['production_code'] as String?,
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int?,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      id: json['id'] as int?,
      name: json['name'] as String?,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
      logo: json['logo'] == null
          ? null
          : Logo.fromJson(json['logo'] as Map<String, dynamic>),
    );

Logo _$LogoFromJson(Map<String, dynamic> json) => Logo(
      path: json['path'] as String?,
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
    );

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      airDate: json['air_date'] == null
          ? null
          : DateTime.parse(json['air_date'] as String),
      episodeCount: json['episode_count'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int?,
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
