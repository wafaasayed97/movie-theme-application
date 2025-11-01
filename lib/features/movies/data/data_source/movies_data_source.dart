import 'package:dartz/dartz.dart';
import 'package:movie_theming_app/core/cache/hive/movie_cache_helper.dart';
import 'package:movie_theming_app/core/error/failure.dart';
import 'package:movie_theming_app/core/network/network_service.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

class MoviesDataSource {
  final NetworkService networkService;
  final MoviesCacheHelper cacheHelper;

  MoviesDataSource({
    required this.networkService,
    required this.cacheHelper,
  });

  Future<Either<Failure, MovieModel>> getMovies(int page) async {
    if (page == 1 && cacheHelper.isCacheValid()) {
      final cachedMovies = cacheHelper.getCachedMovies();
      if (cachedMovies.isNotEmpty) {
        return Right(
          MovieModel(
            page: 1,
            results: cachedMovies,
            totalPages: 500,
            totalResults: cachedMovies.length,
          ),
        );
      }
    }

    final response = await networkService.getData(
      endPoint: "/movie/popular",
      queryParameters: {
        'api_key': '9d542c20b83f5d3a476563de6215e146',
        'language': 'en-US',
        'page': page,
      },
    );

    return response.fold(
      (failure) => Left(failure),
      (json) async {
        try {
          final movieModel = MovieModel.fromJson(json);
          if (movieModel.results != null && movieModel.results!.isNotEmpty) {
            await cacheHelper.cacheMovies(movieModel.results!, page);
          }
          return Right(movieModel);
        } catch (e) {
          return Left(Failure('Failed to parse movies: $e'));
        }
      },
    );
  }

  Future<void> clearCache() async {
    await cacheHelper.clearCache();
  }
}