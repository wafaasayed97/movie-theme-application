import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';

sealed class MoviesState {
  const MoviesState();
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesPaginationLoading extends MoviesState {
  final List<Result> movies;
  const MoviesPaginationLoading(this.movies);
}

final class MoviesSuccess extends MoviesState {
  final List<Result> movies;
  final bool hasMore;
  const MoviesSuccess(this.movies, {this.hasMore = true});
}

final class MoviesFailure extends MoviesState {
  final String message;
  const MoviesFailure(this.message);
}