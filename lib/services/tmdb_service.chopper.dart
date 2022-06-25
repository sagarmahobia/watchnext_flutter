// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TMDBService extends TMDBService {
  _$TMDBService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TMDBService;

  @override
  Future<Response<ListResponse>> getItems(String url,
      {int page = 1, String query = ""}) {
    final $url = 'https://api.themoviedb.org/3/${url}';
    final $params = <String, dynamic>{'page': page, 'query': query};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<ListResponse, ListResponse>($request);
  }

  @override
  Future<Response<Videos>> getVideos(String type, int id) {
    final $url = 'https://api.themoviedb.org/3/${type}/${id}/videos';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Videos, Videos>($request);
  }

  @override
  Future<Response<People>> getPeople(String url, {int page = 1}) {
    final $url = 'https://api.themoviedb.org/3/${url}';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<People, People>($request);
  }

  @override
  Future<Response<CastAndCrew>> getCastAndCrew(String url, {int page = 1}) {
    final $url = 'https://api.themoviedb.org/3/${url}';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<CastAndCrew, CastAndCrew>($request);
  }

  @override
  Future<Response<MovieDetail>> getMovieDetails(int id) {
    final $url = 'https://api.themoviedb.org/3/movie/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<MovieDetail, MovieDetail>($request);
  }

  @override
  Future<Response<TvDetail>> getTvDetails(int id) {
    final $url = 'https://api.themoviedb.org/3/tv/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<TvDetail, TvDetail>($request);
  }

  @override
  Future<Response<PersonDetail>> getPersonDetail(int personId) {
    final $url = 'https://api.themoviedb.org/3/person/${personId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<PersonDetail, PersonDetail>($request);
  }

  @override
  Future<Response<SeasonDetailModel>> getSeasonDetail(
      int tv_id, int season_number) {
    final $url =
        'https://api.themoviedb.org/3//tv/${tv_id}/season/${season_number}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<SeasonDetailModel, SeasonDetailModel>($request);
  }
}
