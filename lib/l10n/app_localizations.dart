import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Test string
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// Greeting word
  ///
  /// In en, this message translates to:
  /// **'hello'**
  String get hello;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Settings menu title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language option
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// User name label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get userName;

  /// Title for new arrival discount offer
  ///
  /// In en, this message translates to:
  /// **'20% Discount New Arrival Product'**
  String get discountNewArrivalTitle;

  /// Description for new arrival discount offer
  ///
  /// In en, this message translates to:
  /// **'Discover amazing discounts on our latest collection. Get 20% off on all new arrival products.'**
  String get discountNewArrivalDescription;

  /// Title for offer shopping
  ///
  /// In en, this message translates to:
  /// **'Take Advantage Of The Offer Shopping'**
  String get takeAdvantageShoppingTitle;

  /// Description for shopping offer
  ///
  /// In en, this message translates to:
  /// **'Don\'t miss out on exclusive shopping deals. Save more on your favorite items with special offers.'**
  String get takeAdvantageShoppingDescription;

  /// Title for all types of offers
  ///
  /// In en, this message translates to:
  /// **'All Types Offers Within Your Reach'**
  String get allTypesOffersTitle;

  /// Description for all types of offers
  ///
  /// In en, this message translates to:
  /// **'Browse through various categories and find the best deals that match your needs and preferences.'**
  String get allTypesOffersDescription;

  /// Welcome title
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcomeTitle;

  /// Description for welcome screen
  ///
  /// In en, this message translates to:
  /// **'Please login or sign up to continue our app'**
  String get welcomeDescription;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTitle;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTitle;

  /// Login button title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// Sign in button title
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTitle;

  /// OR separator
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orTitle;

  /// Google sign-in button title
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogleTitle;

  /// Description for Google login
  ///
  /// In en, this message translates to:
  /// **'Fast and secure login with your Google account'**
  String get continueWithGoogleDescription;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// Prompt to sign up
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountTitle;

  /// Prompt for existing users
  ///
  /// In en, this message translates to:
  /// **'Already a user?'**
  String get alreadyAUserTitle;

  /// Sign up button title
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// Title for login failed error
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailedTitle;

  /// Description for login failed error
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password. Please try again'**
  String get loginFailedDescription;

  /// Title for successful login
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get loginSuccessTitle;

  /// Description for successful login
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Redirecting to home screen'**
  String get loginSuccessDescription;

  /// Description for sign up
  ///
  /// In en, this message translates to:
  /// **'Create an new account'**
  String get signUpDescription;

  /// User name field label
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userNameTitle;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordTitle;

  /// Error title when email is empty
  ///
  /// In en, this message translates to:
  /// **'Email Required'**
  String get emailEmptyTitle;

  /// Error description when email is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailEmptyDescription;

  /// Error description when email is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalidDescription;

  /// Error description when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameEmptyDescription;

  /// Error description when name is too short
  ///
  /// In en, this message translates to:
  /// **'Name is too short'**
  String get nameTooShortDescription;

  /// Error description when password is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordEmptyDescription;

  /// Error description when password is too short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordTooShortDescription;

  /// Error description when password is weak
  ///
  /// In en, this message translates to:
  /// **'Password must contain upper, lower case letters and a number'**
  String get passwordWeakDescription;

  /// Error description when confirm password mismatch
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMustMatch;

  /// Error description when Google sign-in is canceled
  ///
  /// In en, this message translates to:
  /// **'Sign-in canceled'**
  String get googleSignInCanceledDescription;

  /// Error description for Google network issue
  ///
  /// In en, this message translates to:
  /// **'Network connection issue'**
  String get googleNetworkErrorDescription;

  /// Error description when Google sign-in fails
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed'**
  String get googleSignInFailedDescription;

  /// Error description for Google config issue
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In configuration error'**
  String get googleConfigErrorDescription;

  /// Error description for unexpected Google issue
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get googleUnexpectedErrorDescription;

  /// Error description when email already exists
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get emailAlreadyInUseDescription;

  /// Error description for invalid email
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmailDescription;

  /// Error description when operation is not allowed
  ///
  /// In en, this message translates to:
  /// **'Sign-in method disabled'**
  String get operationNotAllowedDescription;

  /// Error description for weak password
  ///
  /// In en, this message translates to:
  /// **'Password too weak'**
  String get weakPasswordDescription;

  /// Error description when user is disabled
  ///
  /// In en, this message translates to:
  /// **'Account disabled'**
  String get userDisabledDescription;

  /// Error description when user not found
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFoundDescription;

  /// Error description when password is incorrect
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrongPasswordDescription;

  /// Error description when credentials are invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentialDescription;

  /// Error description when network request fails
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get networkRequestFailedDescription;

  /// Error description when verification code is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code'**
  String get invalidVerificationCodeDescription;

  /// Error description when verification ID is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid verification ID'**
  String get invalidVerificationIdDescription;

  /// Error description for too many requests
  ///
  /// In en, this message translates to:
  /// **'Too many requests, try later'**
  String get tooManyRequestsDescription;

  /// Error description for internal error
  ///
  /// In en, this message translates to:
  /// **'Internal error occurred'**
  String get internalErrorDescription;

  /// Error description when account exists with different credential
  ///
  /// In en, this message translates to:
  /// **'Account exists with different login'**
  String get accountExistsWithDifferentCredentialDescription;

  /// Error description when credential already in use
  ///
  /// In en, this message translates to:
  /// **'Credentials used elsewhere'**
  String get credentialAlreadyInUseDescription;

  /// Default error description for unexpected auth error
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get defaultAuthErrorDescription;

  /// Menu option for personal details
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// Menu option for orders
  ///
  /// In en, this message translates to:
  /// **'My Order'**
  String get myOrder;

  /// Menu option for favourites
  ///
  /// In en, this message translates to:
  /// **'My Favourites'**
  String get myFavourites;

  /// Menu option for shipping address
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// Menu option for my card
  ///
  /// In en, this message translates to:
  /// **'My Card'**
  String get myCard;

  /// Menu option for notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Toggle for dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Dark mode is turned off
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// Dark mode is turned on
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
