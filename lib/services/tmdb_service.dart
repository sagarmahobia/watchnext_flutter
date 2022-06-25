import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:watchnext/models/cast_and_crew.dart';

import 'dart:convert';

import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/models/person_detail.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/models/video-model.dart';
import 'package:watchnext/pages/person_detail/season_detail_model.dart';

part "tmdb_service.chopper.dart";

final key = "2b3183f319e7b4fa4d6bbaa66289d5c1";

class ModelConverter extends JsonConverter {
  final Map<Type, Function(String json)> typeConverters;

  ModelConverter(this.typeConverters);

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: (typeConverters[BodyType] as Function)(response.bodyString),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);
    return jsonParser(jsonMap);
  }
}

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
      converter: ModelConverter(
        {
          ListResponse: (str) => ListResponse.fromJson(jsonDecode(str)),
          Videos: (str) => Videos.fromJson(jsonDecode(str)),
          People: (str) => People.fromJson(jsonDecode(str)),
          MovieDetail: (str) => MovieDetail.fromJson(jsonDecode(str)),
          TvDetail: (str) => TvDetail.fromJson(jsonDecode(str)),
          PersonDetail: (str) => PersonDetail.fromJson(jsonDecode(str)),
          SeasonDetailModel: (str) => SeasonDetailModel.fromJson(jsonDecode(str)),
          CastAndCrew: (str) => CastAndCrew.fromJson(jsonDecode(str))
        },
      ),
    );

    return _$TMDBService(chopperClient);
  }

  @Get(path: '{url}')
  Future<Response<ListResponse>> getItems(@Path("url") String url,
      {@Query("page") int page = 1, @Query("query") String query = ""});

  @Get(path: '{type}/{id}/videos')
  Future<Response<Videos>> getVideos(@Path("type") String type, @Path("id") int id);

  @Get(path: '{url}')
  Future<Response<People>> getPeople(@Path("url") String url, {@Query("page") int page = 1});

  @Get(path: '{url}')
  Future<Response<CastAndCrew>> getCastAndCrew(@Path("url") String url,
      {@Query("page") int page = 1});

  @Get(path: 'movie/{id}')
  Future<Response<MovieDetail>> getMovieDetails(@Path("id") int id);

  @Get(path: 'tv/{id}')
  Future<Response<TvDetail>> getTvDetails(@Path("id") int id);

  @Get(path: 'person/{person_id}')
  Future<Response<PersonDetail>> getPersonDetail(@Path("person_id") int personId);

// @Get(path: '/tv/{tv_id}/watch/providers')
// Future<Response> getWatchProviders(@pdkjsdnhs)

  @Get(path: '/tv/{tv_id}/season/{season_number}')
  Future<Response<SeasonDetailModel>> getSeasonDetail(
      @Path("tv_id") int tv_id, @Path("season_number") int season_number);
}

class KeyParameterInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final params = Map<String, dynamic>.from(request.parameters);

    params['api_key'] = key;
    return request.copyWith(parameters: params);
  }
}
