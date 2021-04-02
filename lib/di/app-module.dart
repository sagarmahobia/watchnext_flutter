
import 'package:injectable/injectable.dart';
import 'package:watchnext/services/tmdb_service.dart';

@module
abstract class RegisterModule {

  @preResolve
  @singleton
  Future<TMDBService> get prefs async {
    return TMDBService.create();
  }
}
