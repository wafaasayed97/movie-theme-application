import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/core/app_cubit/app_cubit.dart';
import 'package:movie_theming_app/core/extensions/ext.dart';
import 'package:movie_theming_app/core/routes/route_paths.dart';
import 'package:movie_theming_app/core/theme/styles.dart';
import 'package:movie_theming_app/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:movie_theming_app/features/movies/presentation/cubit/movies_state.dart';
import 'package:movie_theming_app/features/movies/presentation/widgets/movie_card_widget.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().getMovies();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _onRefresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    await context.read<MoviesCubit>().refreshMovies();
    setState(() => _isRefreshing = false);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<MoviesCubit>().getMovies(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie, color: Theme.of(context).colorScheme.onPrimary),
            8.wSpace,
            Text(
              'Movies',
              style: font20w600.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              context.read<AppCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          if (state is MoviesFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60.h,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  16.hSpace,
                  Text(
                    state.message,
                    style: font16w500.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  16.hSpace,
                  ElevatedButton(
                    onPressed: () {
                      context.read<MoviesCubit>().getMovies();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'Retry',
                      style: font16w500.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is MoviesSuccess || state is MoviesPaginationLoading) {
            final movies = state is MoviesSuccess
                ? state.movies
                : (state as MoviesPaginationLoading).movies;
            final hasMore = state is MoviesSuccess ? state.hasMore : true;

            if (movies.isEmpty) {
              return Center(
                child: Text(
                  'No movies found',
                  style: font16w500.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: Theme.of(context).colorScheme.primary,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.h),
                itemCount: movies.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == movies.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  }

                  final movie = movies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () {
                      context.push(Routes.movieDetails, extra: movie);
                    },
                  );
                },
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}