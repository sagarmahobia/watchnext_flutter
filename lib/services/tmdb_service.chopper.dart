// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TMDBService extends TMDBService {
  _$TMDBService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TMDBService;

  @override
  Future<Response<dynamic>> getItems(String url,
      {int page = 1, String query = ""}) {
    final $url = 'https://api.themoviedb.org/3/$url';
    final $params = <String, dynamic>{'page': page, 'query': query};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getVideos(String type, int id) {
    final $url = 'https://api.themoviedb.org/3/$type/$id/videos';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPeople(String url, {int page}) {
    final $url = 'https://api.themoviedb.org/3/$url';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDetails(String type, int id) {
    final $url = 'https://api.themoviedb.org/3/$type/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPersonDetail(int personId) {
    final $url = 'https://api.themoviedb.org/3/person/$personId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
