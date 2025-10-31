import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_theming_app/features/movies/presentation/page/movie_screen.dart';

import 'route_observer.dart';
import 'route_paths.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final routes = GoRouter(
  initialLocation: Routes.movieDetails,
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [],
  routes: [
    GoRoute(
      path: Routes.movieDetails,
      builder: (context, state) => const MoviesListScreen(),
      ),
    
    
  ],
);
