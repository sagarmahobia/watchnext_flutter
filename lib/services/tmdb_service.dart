import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

part "tmdb_service.chopper.dart";

final key = "2b3183f319e7b4fa4d6bbaa66289d5c1";

@ChopperApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class TMDBService extends ChopperService {
  // helper methods that help you instantiate your service
  @factoryMethod
  static TMDBService create() {
    var chopperClient = ChopperClient(
      interceptors: [
        KeyParameterInterceptor(),
        HttpLoggingInterceptor(),
        CurlInterceptor(),
      ],
      converter: JsonConverter(),
    );

    return _$TMDBService(chopperClient);
  }

  @Get(path: '{url}')
  Future<Response> getItems(@Path("url") String url,
      {@Query("page") int page = 1, @Query("query") String query = ""});

  @Get(path: '{type}/{id}/videos')
  Future<Response> getVideos(@Path("type") String type, @Path("id") int id);

  @Get(path: '{url}')
  Future<Response> getPeople(@Path("url") String url,
      {@Query("page") int page = 1});

  @Get(path: '{type}/{id}')
  Future<Response> getDetails(@Path("type") String type, @Path("id") int id);

  @Get(path: 'person/{person_id}')
  Future<Response> getPersonDetail(@Path("person_id") int personId);

// @Get(path: '/tv/{tv_id}/watch/providers')
// Future<Response> getWatchProviders(@pdkjsdnhs)


  @Get(path: '/tv/{tv_id}/season/{season_number}')
  Future<Response> getSeasonDetail(@Path("tv_id") int tv_id,
      @Path("season_number") int season_number);


}

class KeyParameterInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final params = Map<String, dynamic>.from(request.parameters);

    params['api_key'] = key;
    return request.copyWith(parameters: params);
  }
}
