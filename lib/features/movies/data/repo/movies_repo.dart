import 'package:dartz/dartz.dart';
import 'package:movie_theming_app/core/error/failure.dart';
import 'package:movie_theming_app/features/movies/data/data_source/movies_data_source.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

class MoviesRepo {
  final MoviesDataSource api;

  MoviesRepo({required this.api});

  Future<Either<Failure, MovieModel>> getMovies(int page) async {
    final result = await api.getMovies(page);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
