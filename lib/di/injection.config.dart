// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app-module.dart';
import '../services/tmdb_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();

  // Eager singletons must be registered in the right order
  final tMDBService = await registerModule.prefs;
  gh.singleton<TMDBService>(tMDBService);
  return get;
}

class _$RegisterModule extends RegisterModule {}
