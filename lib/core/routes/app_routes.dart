import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_observer.dart';
import 'route_paths.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final routes = GoRouter(
  initialLocation: Routes.splashScreen,
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [],
  routes: [
    // GoRoute(
    //   path: Routes.loginScreen,
    //   builder: (_, __) => BlocProvider(
    //     create: (context) => sl<LoginCubit>(),
    //     child: LoginScreen(),
    //   ),
    // ),
    
  ],
);
