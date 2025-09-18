import 'app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';
import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';


class RouterGenerationConfig {
  static GoRouter goRouter() => GoRouter(
    initialLocation: AppRoutes.onboardingScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onboardingScreen,
        name: AppRoutes.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.signInScreen,
        name: AppRoutes.signInScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignInScreen(),
          transitionDuration: const Duration(milliseconds: 1000),
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
