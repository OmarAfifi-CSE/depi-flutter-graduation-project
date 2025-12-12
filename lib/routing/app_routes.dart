class AppRoutes {
  // Authentication Screens
  static const String onboardingScreen = '/onboarding';
  static const String signInScreen = '/sign-in';
  static const String signUpScreen = '/sign-up';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String createNewPasswordScreen = '/create-new-password';
  static const String verificationScreen = '/email-verification';

  // Main Screens
  static const String splashScreen = '/';
  static const String wrapperScreen = '/home';
  static const String categoriesScreen = '/categories';
  static const String cartScreen = '/cart';
  static const String profileScreen = '/profile';

  // Category and Product Screens (with parameters)
  static const String categoryProductsScreen =
      '$categoriesScreen/category-products/:categoryName';
  static const String categoryProductScreen =
      '$categoryProductsScreen/product/:productId';
  static const String manageCategoryScreen = '/manage-category';
  static const String reviewsScreen = '/reviews';
  static const String productScreen = '/product/:productId';

  // Filter Screens
  static const String filterScreen = '/filterScreen';
  static const String filteredProductsScreen = '/filteredProductsScreen';
  static const String filteredProductScreen =
      '$filteredProductsScreen/filteredProduct/:productId';

  // Profile Screens
  static const String wishlistScreen = '/wishlist';
  static const String addressesScreen = '/address';
  static const String addAddressScreen = '/addAddress';
  static const String personalDetailsScreen = '/personalDetails';
  static const String ordersScreen = '/orders';
  static const String orderDetailsScreen = '/orderDetails/:orderId';
  static const String languageSelectionScreen = '/languageSelection';

  // Cart Screens
  static const String checkoutScreen = '/checkout';
  static const String chatsScreen = '/chatsScreen';
  static const String chatScreen = '/chatScreen/:chatId/:otherUserId';
  static const String chatSearchScreen = '/chatSearchScreen';
  static const String orderSuccessfulScreen = '/order-successful';
  static const String manageProductScreen = '/manageProduct';
}
