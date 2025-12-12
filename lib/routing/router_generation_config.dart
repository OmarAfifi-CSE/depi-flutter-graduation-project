import 'package:animations/animations.dart';
import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/controllers/provider/deep_link_provider.dart';
import 'package:batrina/controllers/provider/local_chats_provider.dart';
import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/models/category_model.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/chat_page_models/message_model.dart';
import 'package:batrina/models/order_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/auth/forgot_password_screen.dart';
import 'package:batrina/views/auth/create_new_password_screen.dart';
import 'package:batrina/views/auth/sign_in_screen.dart';
import 'package:batrina/views/auth/sign_up_screen.dart';
import 'package:batrina/views/auth/email_verification_screen.dart';
import 'package:batrina/views/cart/cart_screen.dart';
import 'package:batrina/views/cart/checkout/checkout_screen.dart';
import 'package:batrina/views/cart/checkout/order_successful/order_successful_screen.dart';
import 'package:batrina/views/categories/admin/manage_category/manage_category_screen.dart';
import 'package:batrina/views/categories/categories_screen.dart';
import 'package:batrina/views/categories/category_products/category_products_screen.dart';
import 'package:batrina/views/categories/filter/filter_screen.dart';
import 'package:batrina/views/categories/filter/filtered_products/filtered_products_screen.dart';
import 'package:batrina/views/chat/chat_screen.dart';
import 'package:batrina/views/chat/chats_screen.dart';
import 'package:batrina/views/chat/chat_search_screen.dart';
import 'package:batrina/views/home/home_screen.dart';
import 'package:batrina/views/product/admin/edit_product_screen.dart';
import 'package:batrina/views/product/product_screen.dart';
import 'package:batrina/views/onboarding/onboarding_screen.dart';
import 'package:batrina/views/profile/language_selection/language_selection_screen.dart';
import 'package:batrina/views/profile/orders/order_details/order_details_screen.dart';
import 'package:batrina/views/profile/orders/orders_screen.dart';
import 'package:batrina/views/profile/shipping_address/add_new_address/add_new_address_screen.dart';
import 'package:batrina/views/profile/shipping_address/shipping_address_screen.dart';
import 'package:batrina/views/profile/personal_details/personal_details_screen.dart';
import 'package:batrina/views/profile/profile_screen.dart';
import 'package:batrina/views/profile/wishlist/wishlist_screen.dart';
import 'package:batrina/views/splash_screen.dart';
import 'package:batrina/views/wrapper_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.categoriesScreen,
                  name: AppRoutes.categoriesScreen,
                  builder: (context, state) => const CategoriesScreen(),
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
          path: AppRoutes.categoryProductsScreen,
          name: AppRoutes.categoryProductsScreen,
          pageBuilder: (context, state) {
            final categoryName = state.pathParameters['categoryName'];
            return CustomTransitionPage(
              child: ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
                child: CategoryProductsScreen(categoryName: categoryName!),
              ),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.manageCategoryScreen,
          name: AppRoutes.manageCategoryScreen,
          pageBuilder: (context, state) {
            CategoryCubit categoryCubit;
            CategoryModel? categoryModel;
            if (state.extra is Map) {
              final params = state.extra as Map;
              categoryCubit = params['cubit'];
              categoryModel = params['category'];
            } else {
              categoryCubit = state.extra as CategoryCubit;
              categoryModel = null;
            }
            return CustomTransitionPage(
              child: ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
                child: BlocProvider.value(
                  value: categoryCubit,
                  child: ManageCategoryScreen(categoryModel: categoryModel),
                ),
              ),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.categoryProductScreen,
          name: AppRoutes.categoryProductScreen,
          pageBuilder: (context, state) {
            final productId = state.pathParameters['productId'];
            final size = state.uri.queryParameters['size'];
            final color = state.uri.queryParameters['color'];
            final void Function(ProductModel? pr, BuildContext context)?
            updateItem =
                state.extra
                    as void Function(ProductModel? pr, BuildContext context)?;
            return CustomTransitionPage(
              child: ProductScreen(
                productId: productId!,
                size: size,
                color: color,
                updateItem: updateItem,
              ),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.productScreen,
          name: AppRoutes.productScreen,
          pageBuilder: (context, state) {
            final productId = state.pathParameters['productId'];
            final size = state.uri.queryParameters['size'];
            final color = state.uri.queryParameters['color'];
            final ProductModel? previewModel = state.extra as ProductModel?;
            return CustomTransitionPage(
              child: ProductScreen(
                productId: productId!,
                size: size,
                color: color,
                previewModel: previewModel,
              ),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.filterScreen,
          name: AppRoutes.filterScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const FilterScreen(),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.filteredProductsScreen,
          name: AppRoutes.filteredProductsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const FilteredProductsScreen(),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.filteredProductScreen,
          name: AppRoutes.filteredProductScreen,
          pageBuilder: (context, state) {
            final productId = state.pathParameters['productId'];
            return CustomTransitionPage(
              child: ProductScreen(productId: productId!),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
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
              child: const ShippingAddressScreen(),
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
              child: const AddNewAddressScreen(),
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
          path: AppRoutes.personalDetailsScreen,
          name: AppRoutes.personalDetailsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const PersonalDetailsScreen(),
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
          path: AppRoutes.wishlistScreen,
          name: AppRoutes.wishlistScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const WishlistScreen(),
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
          path: AppRoutes.languageSelectionScreen,
          name: AppRoutes.languageSelectionScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const LanguageSelectionScreen(),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.chatsScreen,
          name: AppRoutes.chatsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const ChatsScreen(),
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
          path: AppRoutes.chatSearchScreen,
          name: AppRoutes.chatSearchScreen,
          pageBuilder: (context, state) {
            Map data = state.extra as Map<String, dynamic>;
            MessageModel? initialMessage = data['initialMessage'];
            List<ConversationModel>? initialList = data['initialList'];
            LocalChatController localChatController = data['provider'];
            return CustomTransitionPage(
              child: ChangeNotifierProvider.value(
                value: localChatController,
                child: ChatSearchScreen(
                  messageModel: initialMessage,
                  initialList: initialList,
                ),
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
          path: AppRoutes.chatScreen,
          name: AppRoutes.chatScreen,
          pageBuilder: (context, state) {
            final String? chatId = state.pathParameters['chatId'];
            final String? otherUserId = state.pathParameters['otherUserId'];
            final extras = state.extra as Map<String, dynamic>;
            final UserModel anotherUserModel = extras['anotherUserModel'];
            final MessageModel? messageModel = extras['initialMessage'];
            return CustomTransitionPage(
              child: ChatScreen(
                chatId: chatId!,
                otherUserId: otherUserId!,
                anotherUser: anotherUserModel,
                initialMessage: messageModel,
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
          path: AppRoutes.checkoutScreen,
          name: AppRoutes.checkoutScreen,
          pageBuilder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            return CustomTransitionPage(
              child: CheckoutScreen(
                cartItems: extras['cartItems'],
                cartPriceProvider: extras['cartPriceProvider'],
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
          path: AppRoutes.orderSuccessfulScreen,
          name: AppRoutes.orderSuccessfulScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const OrderSuccessfulScreen(),
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
          path: AppRoutes.ordersScreen,
          name: AppRoutes.ordersScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const OrdersScreen(),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.orderDetailsScreen,
          name: AppRoutes.orderDetailsScreen,
          pageBuilder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            return CustomTransitionPage(
              child: OrderDetailsScreen(
                order: extras['order'] as OrderModel,
                isAdmin: extras['isAdmin'] as bool,
              ),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.manageProductScreen,
          name: AppRoutes.manageProductScreen,
          pageBuilder: (context, state) {
            final ProductModel? productModel = state.extra as ProductModel?;
            return CustomTransitionPage(
              child: EditProductScreen(productModel: productModel),
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
        if (state.uri.path == "/product") {
          if (state.uri.queryParameters['id'] != null) {
            context.read<DeepLinkProvider>().setDeepLink(
              state.uri.queryParameters['id']!,
            );
          }
          return AppRoutes.splashScreen;
        }
        // If no redirection conditions are met, allow navigation.
        return null;
      },
    );
  }
}
