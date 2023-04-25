import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/cast_and_crew.dart';
import 'package:watchnext/models/collection_detail.dart';
import 'package:watchnext/models/credits_model.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/models/people-model.dart';
import 'package:watchnext/models/person_detail.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/models/video-model.dart' as vm;
import 'package:watchnext/pages/person_detail/season_detail_model.dart';
import 'package:watchnext/services/my_cached_client.dart';

part "tmdb_service.chopper.dart";

final key = "2b3183f319e7b4fa4d6bbaa66289d5c1";

class ModelConverter extends JsonConverter {
  final Map<Type, Function(Map<String, dynamic> json)> typeConverters;

  ModelConverter(this.typeConverters);

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: (typeConverters[BodyType] as Function)(jsonDecode(response.bodyString)),
    );
  }
}

@ChopperApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class TMDBService extends ChopperService {
  // helper methods that help you instantiate your service
  @factoryMethod
  static TMDBService create(prefs) {
    var chopperClient = MyCachedClient(
      cacheManager: prefs,
      interceptors: [
        KeyParameterInterceptor(),
        // HttpLoggingInterceptor(),
      ],
      converter: ModelConverter(
        {
          ListResponse: (json) => ListResponse.fromJson(json),
          Videos: (json) => Videos.fromJson(json),
          People: (json) => People.fromJson(json),
          MovieDetail: (json) => MovieDetail.fromJson(json),
          TvDetail: (json) => TvDetail.fromJson(json),
          PersonDetail: (json) => PersonDetail.fromJson(json),
          SeasonDetailModel: (json) => SeasonDetailModel.fromJson(json),
          CastAndCrew: (json) => CastAndCrew.fromJson(json),
          CreditsModel: (json) => CreditsModel.fromJson(json),
          CollectionDetailModel: (json) => CollectionDetailModel.fromJson(json)
        },
      ),
    );

    return _$TMDBService(chopperClient);
  }

  @Get(path: '{url}')
  Future<Response<ListResponse>> getItems(@Path("url") String url,
      {@Query("page") int page = 1, @Query("query") String query = ""});

  // @Get(path: '{type}/{id}/videos')
  // Future<Response<vm.Videos>> getVideos(@Path("type") String type, @Path("id") int id);

  @Get(path: '{url}')
  Future<Response<People>> getPeople(@Path("url") String url,
      {@Query("page") int page = 1, @Query("query") String query = ""});

  @Get(path: '{url}')
  Future<Response<CastAndCrew>> getCastAndCrew(@Path("url") String url);

  @Get(path: 'movie/{id}?append_to_response=similar,recommendations,credits,videos,images')
  Future<Response<MovieDetail>> getMovieDetails(@Path("id") int id);

  @Get(path: 'tv/{id}?append_to_response=similar,recommendations,credits,videos,images,content_ratings')
  Future<Response<TvDetail>> getTvDetails(@Path("id") int id);

  @Get(path: 'person/{person_id}?append_to_response=movie_credits,tv_credits,images,videos')
  Future<Response<PersonDetail>> getPersonDetail(@Path("person_id") int personId);

// @Get(path: '/tv/{tv_id}/watch/providers')
// Future<Response> getWatchProviders(@pdkjsdnhs)

  @Get(path: '/tv/{tv_id}/season/{season_number}')
  Future<Response<SeasonDetailModel>> getSeasonDetail(
      @Path("tv_id") int tv_id, @Path("season_number") int season_number);

  @Get(path: '/collection/{collection_id}')
  Future<Response<CollectionDetailModel>> getCollection(@Path("collection_id") int id);
}

class KeyParameterInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final params = Map<String, dynamic>.from(request.parameters);

    params['api_key'] = key;
    return request.copyWith(parameters: params);
  }
}
