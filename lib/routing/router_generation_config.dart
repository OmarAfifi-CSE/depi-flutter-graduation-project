import 'package:animations/animations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/auth/forgot_password_screen.dart';
import 'package:batrina/views/auth/create_new_password_screen.dart';
import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/auth/sign_up_screen.dart';
import 'package:batrina/views/auth/email_verification_screen.dart';
import 'package:batrina/views/cart/cart_screen.dart';
import 'package:batrina/views/home/category_screen.dart';
import 'package:batrina/views/home/home_screen.dart';
import 'package:batrina/views/home/product_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';
import 'package:batrina/views/profile/profile_screen.dart';
import 'package:batrina/views/wishlist/screens/wishlist_screen.dart';
import 'package:batrina/views/wrapper_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static String initialLoc = AppRoutes.homeScreen;
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
            path: AppRoutes.createNewPasswordScreen,
            name: AppRoutes.createNewPasswordScreen,
            pageBuilder: (context, state) {
              final oobCode = state.uri.queryParameters['oobCode'];
              return CustomTransitionPage(
                child: CreateNewPasswordScreen(oobCode: oobCode!),
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
            path: AppRoutes.verificationScreen,
            name: AppRoutes.verificationScreen,
            pageBuilder: (context, state) {
              final oobCode = state.uri.queryParameters['oobCode'];
              return CustomTransitionPage(
                child: EmailVerificationScreen(oobCode: oobCode!),
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
        path: AppRoutes.forgotPasswordScreen,
        name: AppRoutes.forgotPasswordScreen,
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return WrapperScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wrapperScreen,
                name: AppRoutes.wrapperScreen,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wishlistScreen,
                name: AppRoutes.wishlistScreen,
                builder: (context, state) => const WishlistScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cartScreen,
                name: AppRoutes.cartScreen,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileScreen,
                name: AppRoutes.profileScreen,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.categoryScreen,
        name: AppRoutes.categoryScreen,
        builder: (context, state) => const CategoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.productScreen,
        name: AppRoutes.productScreen,
        builder: (context, state) => const ProductScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      String? mode;
      String? oobCode;

      if (state.uri.path == '/__/auth/links') {
        final innerLinkString = state.uri.queryParameters['link'];
        if (innerLinkString != null) {
          final innerUri = Uri.parse(innerLinkString);
          mode = innerUri.queryParameters['mode'];
          oobCode = innerUri.queryParameters['oobCode'];
        }
      } else if (state.uri.path == '/action') {
        mode = state.uri.queryParameters['mode'];
        oobCode = state.uri.queryParameters['oobCode'];
      }

      // If we successfully extracted the params, redirect accordingly
      if (mode != null && oobCode != null) {
        switch (mode) {
          case 'resetPassword':
            return '${AppRoutes.signInScreen}${AppRoutes.createNewPasswordScreen}?oobCode=$oobCode';

          case 'verifyEmail':
            return '${AppRoutes.signInScreen}${AppRoutes.verificationScreen}?oobCode=$oobCode';
        }
      }
      // For any other link, don't do anything.
      return null;
    },
  );
}
