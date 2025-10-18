import 'package:animations/animations.dart';
import 'package:batrina/models/product_navigation_data.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/auth/forgot_password_screen.dart';
import 'package:batrina/views/auth/create_new_password_screen.dart';
import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/auth/sign_up_screen.dart';
import 'package:batrina/views/auth/email_verification_screen.dart';
import 'package:batrina/views/cart/cart_screen.dart';
import 'package:batrina/views/home/category_screen.dart';
import 'package:batrina/views/home/category_products_screen.dart';
import 'package:batrina/views/product/product_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';
import 'package:batrina/views/profile/add_address_screen.dart';
import 'package:batrina/views/profile/address_page.dart';
import 'package:batrina/views/profile/personal_details.dart';
import 'package:batrina/views/profile/profile_screen.dart';
import 'package:batrina/views/splash_screen.dart';
import 'package:batrina/views/wrapper_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStateListenable extends ChangeNotifier {
  AuthStateListenable() {
    FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }
}

class RouterGenerationConfig {
  final SharedPreferences sharedPreferences;
  late final GoRouter router;

  RouterGenerationConfig({required this.sharedPreferences}) {
    router = GoRouter(
      refreshListenable: AuthStateListenable(),
      initialLocation: AppRoutes.splashScreen,
      routes: [
        GoRoute(
          path: AppRoutes.splashScreen,
          name: AppRoutes.splashScreen,
          builder: (context, state) =>
              SplashScreen(sharedPreferences: sharedPreferences),
        ),
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
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
                  builder: (context, state) =>
                      const CategoryProductsScreen(categoryName: 'Clothing'),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.wishlistScreen,
                  name: AppRoutes.wishlistScreen,
                  builder: (context, state) => const CategoryScreen(),
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
          path: AppRoutes.productScreen,
          name: AppRoutes.productScreen,
          pageBuilder: (context, state) {
            ProductNavigationData productData =
                (state.extra) as ProductNavigationData;
            return CustomTransitionPage(
              child: ProductScreen(
                productId: productData.productId,
                cartModel: productData.cartModel,
              ),
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
          path: AppRoutes.addressesScreen,
          name: AppRoutes.addressesScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const AddressPage(),
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
          path: AppRoutes.addAddressScreen,
          name: AppRoutes.addAddressScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const AddAddressScreen(),
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
          path: AppRoutes.personalDetails,
          name: AppRoutes.personalDetails,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const PersonalDetails(),
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
        if (mode != null && oobCode != null) {
          switch (mode) {
            case 'resetPassword':
              return '${AppRoutes.signInScreen}${AppRoutes.createNewPasswordScreen}?oobCode=$oobCode';

            case 'verifyEmail':
              return '${AppRoutes.signInScreen}${AppRoutes.verificationScreen}?oobCode=$oobCode';
          }
        }
        // If no redirection conditions are met, allow navigation.
        return null;
      },
    );
  }
}
