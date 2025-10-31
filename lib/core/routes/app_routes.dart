import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/features/movie_details/presentation/page/movie_details_screen.dart';
import 'package:movie_theming_app/features/movies/presentation/page/movie_screen.dart' hide MovieModel;

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
      builder: (context, state) => const MoviesListScreen(),
    ),
    GoRoute(
      path: Routes.movieDetails,
      builder: (context, state) {
        final movie = state.extra as MovieModel;
        return MovieDetailsScreen(movie: movie);
      },
    ),
  ],
);