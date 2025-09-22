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
        routes: [
          GoRoute(
            path: AppRoutes.resetPassword,
            name: AppRoutes.resetPassword,
            pageBuilder: (context, state) {
              final oobCode = state.uri.queryParameters['oobCode'];
              return CustomTransitionPage(
                child: ResetPasswordScreen(oobCode: oobCode!),
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
        ],
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
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // Check if the incoming link is the one from Firebase Auth
      if (state.uri.path == '/__/auth/links') {
        // Find the 'link' query parameter, which contains the actual deep link
        final innerLinkString = state.uri.queryParameters['link'];

        if (innerLinkString != null) {
          // Parse that inner link to access its parameters
          final innerUri = Uri.parse(innerLinkString);
          final oobCode = innerUri.queryParameters['oobCode'];
          final mode = innerUri.queryParameters['mode'];

          // If it's a password reset link, build the correct path for your app
          if (mode == 'resetPassword' && oobCode != null) {
            // Redirect to the route your app already knows how to handle
            return '${AppRoutes.signInScreen}${AppRoutes.resetPassword}?oobCode=$oobCode';
          }
          // You could add more cases here for 'verifyEmail', etc.
        }
      }
      // For any other link, don't do anything.
      return null;
    },
  );
}
