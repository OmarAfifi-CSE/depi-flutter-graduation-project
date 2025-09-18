import 'package:animations/animations.dart';
import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/auth/sign_up_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter() => GoRouter(
    initialLocation: AppRoutes.signUpScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onboardingScreen,
        name: AppRoutes.onboardingScreen,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.signInScreen,
        name: AppRoutes.signInScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignInScreen(),
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.signUpScreen,
        name: AppRoutes.signUpScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignUpScreen(),
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
