import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter() => GoRouter(
    initialLocation: AppRoutes.signInScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onboardingScreen,
        name: AppRoutes.onboardingScreen,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.signInScreen,
        name: AppRoutes.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}
