import 'package:animations/animations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/auth/forget_pass.dart';
import 'package:batrina/views/auth/reset_password_screen.dart';
import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/auth/sign_up_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static String initialLoc = AppRoutes.signInScreen;
  static final GoRouter router = GoRouter(
    initialLocation: initialLoc,
    routes: <RouteBase>[
      // Route للـ reset password
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
      GoRoute(
        path: AppRoutes.signUpScreen,
        name: AppRoutes.signUpScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignUpScreen(),
          reverseTransitionDuration: const Duration(milliseconds: 1000),
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
      GoRoute(
        path: AppRoutes.forgetPassScreen,
        name: AppRoutes.forgetPassScreen,
        pageBuilder: (context, state) {
          final oobCode = state.uri.queryParameters['oobCode'];
          print(oobCode);
          return CustomTransitionPage(
            child: const ForgetPass(),
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                    transitionType: SharedAxisTransitionType.horizontal,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          final oobCode = state.uri.queryParameters['oobCode'];
          final mode = state.uri.queryParameters['mode'];
          final lang = state.uri.queryParameters['lang'];
          return ResetPasswordScreen(oobCode: oobCode!);
        },
      ),
    ],
    errorBuilder: (context, state) {
      final uri = state.uri.toString();

      if (uri.contains("reset.html")) {
        final redirect = Uri.parse(uri).queryParameters['link'];

        if (redirect != null) {
          print("helodfs");
          return const SizedBox.shrink();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text("404: ${state.error}")),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text("404: ${state.error}")),
        );
      }
    },
  );
}
