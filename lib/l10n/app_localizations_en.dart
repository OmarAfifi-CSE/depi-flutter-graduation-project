// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get test => 'Test';

  @override
  String get hello => 'hello';

  @override
  String get welcome => 'Welcome';

  @override
  String userName(Object name) {
    return 'name';
  }

  @override
  String get discountNewArrivalTitle => '20% Discount New Arrival Product';

  @override
  String get discountNewArrivalDescription =>
      'Discover amazing discounts on our latest collection. Get 20% off on all new arrival products.';

  @override
  String get takeAdvantageShoppingTitle =>
      'Take Advantage Of The Offer Shopping';

  @override
  String get takeAdvantageShoppingDescription =>
      'Don\'t miss out on exclusive shopping deals. Save more on your favorite items with special offers.';

  @override
  String get allTypesOffersTitle => 'All Types Offers Within Your Reach';

  @override
  String get allTypesOffersDescription =>
      'Browse through various categories and find the best deals that match your needs and preferences.';

  @override
  String get welcomeTitle => 'Welcome!';

  @override
  String get welcomeDescription =>
      'Please login or sign up to continue our app';

  @override
  String get emailTitle => 'Email';

  @override
  String get passwordTitle => 'Password';

  @override
  String get loginTitle => 'Login';

  @override
  String get signInTitle => 'Sign In';

  @override
  String get orTitle => 'or';

  @override
  String get continueWithGoogleTitle => 'Continue with Google';

  @override
  String get continueWithGoogleDescription =>
      'Fast and secure login with your Google account';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get dontHaveAccountTitle => 'Don\'t have an account?';

  @override
  String get alreadyAUserTitle => 'Already a user?';

  @override
  String get signUpTitle => 'Sign Up';

  @override
  String get loginFailedTitle => 'Login Failed';

  @override
  String get loginFailedDescription =>
      'Invalid email or password. Please try again';

  @override
  String get loginSuccessTitle => 'Login Successful';

  @override
  String get loginSuccessDescription =>
      'Welcome back! Redirecting to home screen';

  @override
  String get signUpDescription => 'Create an new account';

  @override
  String get userNameTitle => 'User Name';

  @override
  String get confirmPasswordTitle => 'Confirm Password';

  @override
  String get emailEmptyTitle => 'Email Required';

  @override
  String get emailEmptyDescription => 'Please enter your email';

  @override
  String get emailInvalidDescription => 'Please enter a valid email address';

  @override
  String get nameEmptyDescription => 'Name is required';

  @override
  String get nameTooShortDescription => 'Name is too short';

  @override
  String get passwordEmptyDescription => 'Please enter your password';

  @override
  String get passwordTooShortDescription =>
      'Password must be at least 6 characters long';

  @override
  String get passwordWeakDescription =>
      'Password must contain upper, lower case letters and a number';

  @override
  String get googleSignInCanceledDescription => 'Sign-in canceled';

  @override
  String get googleNetworkErrorDescription => 'Network connection issue';

  @override
  String get googleSignInFailedDescription => 'Sign-in failed';

  @override
  String get googleConfigErrorDescription =>
      'Google Sign-In configuration error';

  @override
  String get googleUnexpectedErrorDescription => 'Unexpected error occurred';

  @override
  String get emailAlreadyInUseDescription => 'Email already registered';

  @override
  String get invalidEmailDescription => 'Invalid email address';

  @override
  String get operationNotAllowedDescription => 'Sign-in method disabled';

  @override
  String get weakPasswordDescription => 'Password too weak';

  @override
  String get userDisabledDescription => 'Account disabled';

  @override
  String get userNotFoundDescription => 'User not found';

  @override
  String get wrongPasswordDescription => 'Incorrect password';

  @override
  String get invalidCredentialDescription => 'Invalid credentials';

  @override
  String get networkRequestFailedDescription => 'Connection failed';

  @override
  String get invalidVerificationCodeDescription => 'Invalid verification code';

  @override
  String get invalidVerificationIdDescription => 'Invalid verification ID';

  @override
  String get tooManyRequestsDescription => 'Too many requests, try later';

  @override
  String get internalErrorDescription => 'Internal error occurred';

  @override
  String get accountExistsWithDifferentCredentialDescription =>
      'Account exists with different login';

  @override
  String get credentialAlreadyInUseDescription => 'Credentials used elsewhere';

  @override
  String get defaultAuthErrorDescription => 'Unexpected error occurred';

  @override
  String get passwordMustMatch => 'Passwords do not match ';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordLabel =>
      'Enter the email assoicated wth your account and we\'ll send an email with instuction to reset your password';

  @override
  String get sendInstruction => 'Send Instruction';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get reset => 'Reset';

  @override
  String get expiredActionCodeDescription =>
      'The link has expired. Please request a new one.';

  @override
  String get invalidActionCodeDescription =>
      'The link is invalid. Please request a new one.';

  @override
  String get emailVerifiedTitle => 'Email Verified!';

  @override
  String get emailVerifiedSubtitle =>
      'Your account is now active and ready to use. Thank you for joining us.';

  @override
  String get continueToSignInButton => 'Continue to Sign In';

  @override
  String get verificationFailedTitle => 'Verification Failed';

  @override
  String get backToSignInButton => 'Back to Sign In';

  @override
  String get signin_success => 'Signed in successfully';

  @override
  String get check_email_activation =>
      'Please check your email to activate your account.';

  @override
  String get forget_password_sent => 'Sent successfully';

  @override
  String get something_went_wrong => 'Something went wrong.';

  @override
  String get close => 'Close';

  @override
  String get login_success => 'Signed in successfully';

  @override
  String get create_new_password => 'Create New Password';

  @override
  String get password_changed_success => 'Password changed successfully';

  @override
  String get confirm => 'Confirm';

  @override
  String get invalid_or_expired_link =>
      'The link is invalid, expired, or has already been used. Please request a new one.';

  @override
  String get unexpected_error =>
      'An unexpected error occurred. Please try again.';

  @override
  String get error_happened => 'Error happened';

  @override
  String get home => 'Home';

  @override
  String get categories => 'Categories';

  @override
  String get cart => 'Cart';

  @override
  String get favorites => 'Wishlist';

  @override
  String get notifications => 'Notifications';

  @override
  String get profile => 'Profile';

  @override
  String get search => 'Search';

  @override
  String get emptyCategories => 'No categories found';

  @override
  String get defaultError => 'An unexpected error occurred.';

  @override
  String get personalDetails => 'Personal Details';

  @override
  String get myOrders => 'My Order';

  @override
  String get myFavourites => 'My Favourites';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get myCard => 'My Card';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get english => 'English';

  @override
  String get addtocard => 'Add to Card';

  @override
  String get processtocheckout => 'Proceed to Checkout';

  @override
  String get mycart => 'My Cart';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get shipping => 'Shipping';

  @override
  String get total => 'Total';

  @override
  String get items => 'items';

  @override
  String get review => 'Review';

  @override
  String get availableinstock => 'Available in stock';

  @override
  String get description => 'Description';

  @override
  String get reviewsHeader => 'Customer Reviews';

  @override
  String get reviewsLoadingError => 'Something went wrong. Please try again.';

  @override
  String get noReviewsYet =>
      'No reviews yet. Be the first to share your thoughts!';

  @override
  String get addReviewTitle => 'Write a Review';

  @override
  String get experienceHint => 'How was your experience with this product?';

  @override
  String get postButton => 'Post';

  @override
  String get errorHappened => 'Error happened!';

  @override
  String get reviews => 'Reviews';

  @override
  String get size => 'Size';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get notAvailable => 'Not available';

  @override
  String get noAvailableSizes => 'No available Sizes';

  @override
  String get noAvailableColors => 'No available Colors';

  @override
  String get streetEmptyDescription => 'Street address is required';

  @override
  String get streetTooShortDescription => 'Street address is too short';

  @override
  String get cityEmptyDescription => 'City is required';

  @override
  String get cityTooShortDescription => 'City name is too short';

  @override
  String get countryEmptyDescription => 'Country is required';

  @override
  String get countryTooShortDescription => 'Country name is too short';

  @override
  String get phoneEmptyDescription => 'Phone number is required';

  @override
  String get phoneInvalidDescription =>
      'Phone number must contain only numbers';

  @override
  String get phoneLengthDescription =>
      'Phone number must be between 8 and 15 digits';
}
