// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:watchnext/di/app-module.dart' as _i7;
import 'package:watchnext/services/my_cached_client.dart' as _i4;
import 'package:watchnext/services/pref_manager.dart' as _i5;
import 'package:watchnext/services/tmdb_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i4.CacheManager>(
        _i4.CacheManager(gh<_i3.SharedPreferences>()));
    gh.singleton<_i5.CacheManger>(_i5.CacheManger(gh<_i3.SharedPreferences>()));
    await gh.singletonAsync<_i6.TMDBService>(
      () => registerModule.apis(gh<_i5.CacheManger>()),
      preResolve: true,
    );
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
