// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TMDBService extends TMDBService {
  _$TMDBService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TMDBService;

  @override
  Future<Response<ListResponse>> getItems(
    String url, {
    int page = 1,
    String query = "",
  }) {
    final Uri $url = Uri.parse('https://api.themoviedb.org/3/${url}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'query': query,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ListResponse, ListResponse>($request);
  }

  @override
  Future<Response<People>> getPeople(
    String url, {
    int page = 1,
    String query = "",
  }) {
    final Uri $url = Uri.parse('https://api.themoviedb.org/3/${url}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'query': query,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<People, People>($request);
  }

  @override
  Future<Response<CastAndCrew>> getCastAndCrew(String url) {
    final Uri $url = Uri.parse('https://api.themoviedb.org/3/${url}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CastAndCrew, CastAndCrew>($request);
  }

  @override
  Future<Response<MovieDetail>> getMovieDetails(int id) {
    final Uri $url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${id}?append_to_response=similar,recommendations,credits,videos,images');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MovieDetail, MovieDetail>($request);
  }

  @override
  Future<Response<TvDetail>> getTvDetails(int id) {
    final Uri $url = Uri.parse(
        'https://api.themoviedb.org/3/tv/${id}?append_to_response=similar,recommendations,credits,videos,images,content_ratings');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TvDetail, TvDetail>($request);
  }

  @override
  Future<Response<PersonDetail>> getPersonDetail(int personId) {
    final Uri $url = Uri.parse(
        'https://api.themoviedb.org/3/person/${personId}?append_to_response=movie_credits,tv_credits,images,videos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PersonDetail, PersonDetail>($request);
  }

  @override
  Future<Response<SeasonDetailModel>> getSeasonDetail(
    int tv_id,
    int season_number,
  ) {
    final Uri $url = Uri.parse(
        'https://api.themoviedb.org/3//tv/${tv_id}/season/${season_number}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeasonDetailModel, SeasonDetailModel>($request);
  }

  @override
  Future<Response<CollectionDetailModel>> getCollection(int id) {
    final Uri $url =
        Uri.parse('https://api.themoviedb.org/3//collection/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CollectionDetailModel, CollectionDetailModel>($request);
  }
}
