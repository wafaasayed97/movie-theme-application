import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/core/di/services_locator.dart';
import 'package:movie_theming_app/features/movie_details/presentation/page/movie_details_screen.dart';
import 'package:movie_theming_app/features/movies/data/models/movies_model.dart';
import 'package:movie_theming_app/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:movie_theming_app/features/movies/presentation/page/movie_screen.dart';

import 'route_observer.dart';
import 'route_paths.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final routes = GoRouter(
  initialLocation: Routes.movielist,
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [],
  routes: [
    GoRoute(
      path: Routes.movielist,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<MoviesCubit>(),
        child: const MoviesListScreen(),
      ),
    ),
    GoRoute(
      path: Routes.movieDetails,
      builder: (context, state) {
        final movie = state.extra as Result;
        return MovieDetailsScreen(movie: movie);
      },
    ),
  ],
);