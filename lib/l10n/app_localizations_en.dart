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
  String get settings => 'Sittings';

  @override
  String get language => 'lan';

  @override
  String userName(Object name) {
    return 'name';
  }

  @override
  String get discountNewArrivalTitle => '20% Discount New Arrival Product';

  @override
  String get discountNewArrivalDescription => 'Discover amazing discounts on our latest collection. Get 20% off on all new arrival products.';

  @override
  String get takeAdvantageShoppingTitle => 'Take Advantage Of The Offer Shopping';

  @override
  String get takeAdvantageShoppingDescription => 'Don\'t miss out on exclusive shopping deals. Save more on your favorite items with special offers.';

  @override
  String get allTypesOffersTitle => 'All Types Offers Within Your Reach';

  @override
  String get allTypesOffersDescription => 'Browse through various categories and find the best deals that match your needs and preferences.';

  @override
  String get welcomeTitle => 'Welcome!';

  @override
  String get welcomeDescription => 'Please login or sign up to continue our app';

  @override
  String get emailTitle => 'Email';

  @override
  String get passwordTitle => 'Password';

  @override
  String get loginTitle => 'Login';

  @override
  String get orTitle => 'or';

  @override
  String get continueWithGoogleTitle => 'Continue with Google';

  @override
  String get continueWithGoogleDescription => 'Fast and secure login with your Google account';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get dontHaveAccountTitle => 'Don\'t have an account?';

  @override
  String get signUpTitle => 'Sign Up';

  @override
  String get loginFailedTitle => 'Login Failed';

  @override
  String get loginFailedDescription => 'Invalid email or password. Please try again';

  @override
  String get loginSuccessTitle => 'Login Successful';

  @override
  String get loginSuccessDescription => 'Welcome back! Redirecting to home screen';

  @override
  String get signUpDescription => 'Create an new account';

  @override
  String get userNameTitle => 'User Name';

  @override
  String get confirmPasswordTitle => 'Confirm Password';

  @override
  String get agreeTermsTitle => 'By creating an account you have to agree with our them & condication.';

  @override
  String get emailEmptyTitle => 'Email Required';

  @override
  String get emailEmptyDescription => 'Please enter your email !';

  @override
  String get emailInvalidDescription => 'Please enter a valid email address !';

  @override
  String get nameEmptyDescription => 'Name is required !';

  @override
  String get nameTooShortDescription => 'Name is too short !';

  @override
  String get passwordEmptyDescription => 'Please enter your password !';

  @override
  String get passwordTooShortDescription => 'Password must be at least 6 characters long !';

  @override
  String get passwordWeakTitle => 'Weak Password';

  @override
  String get passwordWeakDescription => 'Password must contain upper, lower case letters and a number !';
}
