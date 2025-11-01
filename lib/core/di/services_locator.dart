import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_theming_app/core/cache/hive/hive_helper.dart';
import 'package:movie_theming_app/core/cache/hive/movie_cache_helper.dart';
import 'package:movie_theming_app/core/network/network_service.dart';
import 'package:movie_theming_app/core/network/session_manager.dart';
import 'package:movie_theming_app/features/movies/data/data_source/movies_data_source.dart';
import 'package:movie_theming_app/features/movies/data/repo/movies_repo.dart';
import 'package:movie_theming_app/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/secure_storage/secure_storage.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    _initFlutterSecureStorage();

    await _initSharedPreferencesStorage();

    _initDioService();

    _initSessionManager();

    await _initHiveHelper(); // ✅ await this before _initMovies

    _initMovies();
  }

  Future<void> _initSharedPreferencesStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => PreferencesStorage(sharedPreferences));
  }

  void _initFlutterSecureStorage() {
    final secureStorage = FlutterSecureStorage();
    sl.registerLazySingleton(() => SecureStorage(secureStorage));
  }

  void _initSessionManager() {
    sl.registerLazySingleton(() => SessionManager(sl(), sl(), sl()));
  }

  void _initDioService() {
    sl.registerLazySingleton(() => NetworkService(Dio()));
  }

  Future<void> _initHiveHelper() async {
    final hiveHelper = HiveHelper();
    await hiveHelper.init();

    sl.registerLazySingleton(() => hiveHelper);

    sl.registerLazySingleton<MoviesCacheHelper>(
      () => MoviesCacheHelper(sl<HiveHelper>()),
    );
  }

  void _initMovies() {
    sl.registerLazySingleton(
      () => MoviesDataSource(networkService: sl(), cacheHelper: sl()),
    );
    sl.registerLazySingleton(() => MoviesRepo(api: sl()));
    sl.registerFactory(() => MoviesCubit(sl()));
  }
}
