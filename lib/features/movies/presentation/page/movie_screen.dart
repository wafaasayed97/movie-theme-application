import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/core/app_cubit/app_cubit.dart';
import 'package:movie_theming_app/core/extensions/ext.dart';
import 'package:movie_theming_app/core/routes/route_paths.dart';
import 'package:movie_theming_app/core/theme/styles.dart';
import 'package:movie_theming_app/features/movie_details/presentation/page/movie_details_screen.dart';
import 'package:movie_theming_app/features/movies/presentation/widgets/movie_card_widget.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final List<MovieModel> _movies = [
    MovieModel(title: 'The Matrix', rating: 8.7, genre: 'Sci-Fi'),
    MovieModel(title: 'Fight Club', rating: 8.8, genre: 'Drama'),
    MovieModel(title: 'Forrest Gump', rating: 8.8, genre: 'Drama'),
    MovieModel(title: 'The Shawshank Redemption', rating: 9.3, genre: 'Drama'),
    MovieModel(title: 'The Godfather', rating: 9.2, genre: 'Crime'),
  ];

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
      body: ListView.builder(
        padding: EdgeInsets.all(16.h),
        itemCount: _movies.length + 1,
        itemBuilder: (context, index) {
          if (index == _movies.length) {
            return Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: Text(
                    'Load More Movies',
                    style: font16w500.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
            );
          }

          return MovieCard(
            movie: _movies[index],
            onTap: () {
              context.push(Routes.movieDetails, extra: _movies[index]);
            },
          );
        },
      ),
    );
  }
}
