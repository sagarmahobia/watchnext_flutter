// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../services/my_cached_client.dart' as _i4;
import '../services/pref_manager.dart' as _i5;
import '../services/tmdb_service.dart' as _i6;
import 'app-module.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  await gh.singletonAsync<_i3.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i4.CacheManager>(
      _i4.CacheManager(get<_i3.SharedPreferences>()));
  gh.singleton<_i5.CacheManger>(_i5.CacheManger(get<_i3.SharedPreferences>()));
  await gh.singletonAsync<_i6.TMDBService>(
    () => registerModule.apis(get<_i5.CacheManger>()),
    preResolve: true,
  );
  return get;
}

class _$RegisterModule extends _i7.RegisterModule {}
