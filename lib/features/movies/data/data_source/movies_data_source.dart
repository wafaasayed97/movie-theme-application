import 'package:dartz/dartz.dart';
import 'package:movie_theming_app/core/error/failure.dart';
import 'package:movie_theming_app/core/network/endpoints.dart';
import 'package:movie_theming_app/core/network/network_service.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

class MoviesDataSource {
  final NetworkService networkService;
  MoviesDataSource(this.networkService);

  Future<Either<Failure, MovieModel>> getMovies(int page) async {
    final response = await networkService.getData(
      endPoint: "${EndPoints.moviesList}$page",
      queryParameters: {
        'api_key': '9d542c20b83f5d3a476563de6215e146',
        'page': page,
      },
    );
    return response.fold((l) => Left(l), (r) {
      return Right(MovieModel.fromJson(r));
    });
  }
}
