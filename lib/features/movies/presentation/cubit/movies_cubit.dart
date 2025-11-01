import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';
import 'package:movie_theming_app/features/movies/data/repo/movies_repo.dart';
import 'package:movie_theming_app/features/movies/presentation/cubit/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepo moviesRepo;
  MoviesCubit(this.moviesRepo) : super(MoviesInitial());

  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  final List<Result> _movies = [];

  List<Result> get movies => _movies;

  Future<void> getMovies({bool loadMore = false}) async {
    if (_isLoading) return;
    if (loadMore && !_hasMore) return;

    _isLoading = true;

    if (!loadMore) {
      emit(MoviesLoading());
      _currentPage = 1;
      _movies.clear();
      _hasMore = true;
    } else {
      emit(MoviesPaginationLoading(_movies));
    }

    final result = await moviesRepo.getMovies(_currentPage);

    result.fold(
      (failure) {
        emit(MoviesFailure(failure.message));
        _isLoading = false;
      },
      (movieModel) {
        if (movieModel.results != null) {
          _movies.addAll(movieModel.results!);
          _currentPage++;
          _hasMore = _currentPage <= (movieModel.totalPages ?? 0);
        } else {
          _hasMore = false;
        }

        emit(MoviesSuccess(_movies, hasMore: _hasMore));
        _isLoading = false;
      },
    );
  }

  Future<void> refreshMovies() async {
    await moviesRepo.clearCache();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    _movies.clear();
    await getMovies();
  }

  void resetMovies() {
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    _movies.clear();
    emit(MoviesInitial());
  }
}