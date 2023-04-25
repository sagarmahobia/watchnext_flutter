import 'dart:convert';
import 'dart:typed_data';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchnext/services/pref_manager.dart';

int getFactoredAge(int maxAge) {
  var factor = 1;
  if (maxAge <= 600) {
    factor = 144;
  } else if (maxAge <= 1200) {
    factor = 72;
  } else if (maxAge <= 2400) {
    factor = 36;
  } else if (maxAge <= 4800) {
    factor = 18;
  } else if (maxAge <= 9600) {
    factor = 9;
  } else if (maxAge <= 19200) {
    factor = 4;
  } else if (maxAge <= 21600) {
    factor = 2;
  } else {
    factor = 1;
  }
  return maxAge * factor;
}

class MyCachedClient extends ChopperClient {
  final CacheManger cacheManager;

  MyCachedClient({
    required List<RequestInterceptor> interceptors,
    required Converter converter,
    required this.cacheManager,
  }) : super(
          converter: converter,
          interceptors: interceptors,
        );

  Future<Response<BodyType>> send<BodyType, InnerType>(
    Request request, {
    ConvertRequest? requestConverter,
    ConvertResponse? responseConverter,
  }) async {
    String? cache = cacheManager.getCacheOrRemoveIfExpired(request.url.toString());

    if (cache != null) {
      final response = http.Response.bytes(
        cache.toUint8List(),
        200,
      );

      if (converter == null) {
        throw Exception("Converter is null");
      }
      var convertResponse =
          await converter!.convertResponse<BodyType, InnerType>(Response(response, response.body));
      return convertResponse;
    }

    var send = await super.send<BodyType, InnerType>(request,
        requestConverter: requestConverter, responseConverter: responseConverter);

    if (send.isSuccessful) {
      var maxAge = getMaxAge(send.headers);

      if (maxAge != null) {
        maxAge = getFactoredAge(maxAge);
        print("maxAgeFactored: $maxAge");

        var expires = DateTime.now().add(Duration(seconds: maxAge));
        cacheManager.cacheResponse(request.url.toString(), send.bodyString, expires);
      }
    }

    return send;
  }

  int? getMaxAge(headers) {
    String? cacheControlHeader = headers['Cache-Control'.toLowerCase()];
    if (cacheControlHeader != null) {
      List<String> parts = cacheControlHeader.split(',');
      for (String part in parts) {
        part = part.trim();
        if (part.startsWith('max-age=')) {
          String maxAgeString = part.substring(8);
          return int.tryParse(maxAgeString);
        }
      }
    }
    return null;
  }
}

extension on String {
  List<int> toBytes() {
    return utf8.encode(this);
  }

  Uint8List toUint8List() {
    return Uint8List.fromList(toBytes());
  }
}

@singleton
class CacheManager {
  final SharedPreferences prefs;

  CacheManager(this.prefs);
}
