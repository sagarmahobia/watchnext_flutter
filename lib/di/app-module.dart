import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchnext/services/pref_manager.dart';
import 'package:watchnext/services/tmdb_service.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<TMDBService> get apis async {
    return TMDBService.create();
  }

  @preResolve
  @singleton
  Future<SharedPreferences> get prefs async {
    return SharedPreferences.getInstance();
  }
}
