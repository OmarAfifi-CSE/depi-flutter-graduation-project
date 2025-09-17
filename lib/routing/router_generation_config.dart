import 'package:batrina/test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter() => GoRouter(
    // initialLocation: AppRoutes.mainScreen,
    routes: [
      GoRoute(
        // path: AppRoutes.onboardingScreen,
        // name: AppRoutes.onboardingScreen,
        path: "/",
        builder: (context, state) => const Test(),
      ),
    ],
  );
}
