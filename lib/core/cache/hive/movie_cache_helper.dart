import 'dart:convert';
import 'package:movie_theming_app/core/cache/hive/hive_helper.dart';
import 'package:movie_theming_app/core/cache/hive/hive_keys.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

class MoviesCacheHelper {
  final HiveHelper _hiveHelper;

  MoviesCacheHelper(this._hiveHelper);

  static const Duration _cacheValidDuration = Duration(hours: 24);

  Future<void> cacheMovies(List<Result> movies, int page) async {
    final existingCache = _getCachedMoviesList();
    
    if (page == 1) {
      existingCache.clear();
    }
    
    existingCache.addAll(movies);

    final moviesJson = existingCache.map((m) => m.toJson()).toList();
    await _hiveHelper.write(HiveKeys.moviesList, jsonEncode(moviesJson));
    await _hiveHelper.write(HiveKeys.moviesPage, page);
    await _hiveHelper.write(
      HiveKeys.moviesCacheTimestamp,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  List<Result> getCachedMovies() {
    if (!isCacheValid()) {
      return [];
    }
    return _getCachedMoviesList();
  }

  List<Result> _getCachedMoviesList() {
    final moviesJson = _hiveHelper.read(HiveKeys.moviesList);
    if (moviesJson == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(moviesJson);
      return decoded.map((json) => Result.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  int getCachedPage() {
    return _hiveHelper.read(HiveKeys.moviesPage) ?? 0;
  }

  bool isCacheValid() {
    final timestamp = _hiveHelper.read(HiveKeys.moviesCacheTimestamp);
    if (timestamp == null) return false;

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    return now.difference(cachedTime) < _cacheValidDuration;
  }

  Future<void> clearCache() async {
    await _hiveHelper.delete(HiveKeys.moviesList);
    await _hiveHelper.delete(HiveKeys.moviesPage);
    await _hiveHelper.delete(HiveKeys.moviesCacheTimestamp);
  }
}