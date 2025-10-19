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

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'hello'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String userName(Object name);

  /// No description provided for @discountNewArrivalTitle.
  ///
  /// In en, this message translates to:
  /// **'20% Discount New Arrival Product'**
  String get discountNewArrivalTitle;

  /// No description provided for @discountNewArrivalDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover amazing discounts on our latest collection. Get 20% off on all new arrival products.'**
  String get discountNewArrivalDescription;

  /// No description provided for @takeAdvantageShoppingTitle.
  ///
  /// In en, this message translates to:
  /// **'Take Advantage Of The Offer Shopping'**
  String get takeAdvantageShoppingTitle;

  /// No description provided for @takeAdvantageShoppingDescription.
  ///
  /// In en, this message translates to:
  /// **'Don\'t miss out on exclusive shopping deals. Save more on your favorite items with special offers.'**
  String get takeAdvantageShoppingDescription;

  /// No description provided for @allTypesOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'All Types Offers Within Your Reach'**
  String get allTypesOffersTitle;

  /// No description provided for @allTypesOffersDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse through various categories and find the best deals that match your needs and preferences.'**
  String get allTypesOffersDescription;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcomeTitle;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Please login or sign up to continue our app'**
  String get welcomeDescription;

  /// No description provided for @emailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTitle;

  /// No description provided for @passwordTitle.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTitle;

  /// No description provided for @orTitle.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orTitle;

  /// No description provided for @continueWithGoogleTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogleTitle;

  /// No description provided for @continueWithGoogleDescription.
  ///
  /// In en, this message translates to:
  /// **'Fast and secure login with your Google account'**
  String get continueWithGoogleDescription;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @dontHaveAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountTitle;

  /// No description provided for @alreadyAUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Already a user?'**
  String get alreadyAUserTitle;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// No description provided for @loginFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailedTitle;

  /// No description provided for @loginFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password. Please try again'**
  String get loginFailedDescription;

  /// No description provided for @loginSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get loginSuccessTitle;

  /// No description provided for @loginSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Redirecting to home screen'**
  String get loginSuccessDescription;

  /// No description provided for @signUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Create an new account'**
  String get signUpDescription;

  /// No description provided for @userNameTitle.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userNameTitle;

  /// No description provided for @confirmPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordTitle;

  /// No description provided for @emailEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Required'**
  String get emailEmptyTitle;

  /// No description provided for @emailEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailEmptyDescription;

  /// No description provided for @emailInvalidDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalidDescription;

  /// No description provided for @nameEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameEmptyDescription;

  /// No description provided for @nameTooShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Name is too short'**
  String get nameTooShortDescription;

  /// No description provided for @passwordEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordEmptyDescription;

  /// No description provided for @passwordTooShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordTooShortDescription;

  /// No description provided for @passwordWeakDescription.
  ///
  /// In en, this message translates to:
  /// **'Password must contain upper, lower case letters and a number'**
  String get passwordWeakDescription;

  /// No description provided for @pleaseVerifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email first'**
  String get pleaseVerifyYourEmail;

  /// No description provided for @googleSignInCanceledDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign-in canceled'**
  String get googleSignInCanceledDescription;

  /// No description provided for @googleNetworkErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Network connection issue'**
  String get googleNetworkErrorDescription;

  /// No description provided for @googleSignInFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed'**
  String get googleSignInFailedDescription;

  /// No description provided for @googleConfigErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In configuration error'**
  String get googleConfigErrorDescription;

  /// No description provided for @googleUnexpectedErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get googleUnexpectedErrorDescription;

  /// No description provided for @emailAlreadyInUseDescription.
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get emailAlreadyInUseDescription;

  /// No description provided for @invalidEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmailDescription;

  /// No description provided for @operationNotAllowedDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign-in method disabled'**
  String get operationNotAllowedDescription;

  /// No description provided for @weakPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Password too weak'**
  String get weakPasswordDescription;

  /// No description provided for @userDisabledDescription.
  ///
  /// In en, this message translates to:
  /// **'Account disabled'**
  String get userDisabledDescription;

  /// No description provided for @userNotFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFoundDescription;

  /// No description provided for @wrongPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrongPasswordDescription;

  /// No description provided for @invalidCredentialDescription.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentialDescription;

  /// No description provided for @networkRequestFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get networkRequestFailedDescription;

  /// No description provided for @invalidVerificationCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code'**
  String get invalidVerificationCodeDescription;

  /// No description provided for @invalidVerificationIdDescription.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification ID'**
  String get invalidVerificationIdDescription;

  /// No description provided for @tooManyRequestsDescription.
  ///
  /// In en, this message translates to:
  /// **'Too many requests, try later'**
  String get tooManyRequestsDescription;

  /// No description provided for @internalErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Internal error occurred'**
  String get internalErrorDescription;

  /// No description provided for @accountExistsWithDifferentCredentialDescription.
  ///
  /// In en, this message translates to:
  /// **'Account exists with different login'**
  String get accountExistsWithDifferentCredentialDescription;

  /// No description provided for @credentialAlreadyInUseDescription.
  ///
  /// In en, this message translates to:
  /// **'Credentials used elsewhere'**
  String get credentialAlreadyInUseDescription;

  /// No description provided for @defaultAuthErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get defaultAuthErrorDescription;

  /// No description provided for @passwordMustMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match '**
  String get passwordMustMatch;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter the email assoicated wth your account and we\'ll send an email with instuction to reset your password'**
  String get resetPasswordLabel;

  /// No description provided for @sendInstruction.
  ///
  /// In en, this message translates to:
  /// **'Send Instruction'**
  String get sendInstruction;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @expiredActionCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'The link has expired. Please request a new one.'**
  String get expiredActionCodeDescription;

  /// No description provided for @invalidActionCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'The link is invalid. Please request a new one.'**
  String get invalidActionCodeDescription;

  /// No description provided for @emailVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verified!'**
  String get emailVerifiedTitle;

  /// No description provided for @emailVerifiedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account is now active and ready to use. Thank you for joining us.'**
  String get emailVerifiedSubtitle;

  /// No description provided for @continueToSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Continue to Sign In'**
  String get continueToSignInButton;

  /// No description provided for @verificationFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Failed'**
  String get verificationFailedTitle;

  /// No description provided for @backToSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignInButton;

  /// No description provided for @signin_success.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully'**
  String get signin_success;

  /// No description provided for @check_email_activation.
  ///
  /// In en, this message translates to:
  /// **'Please check your email to activate your account.'**
  String get check_email_activation;

  /// No description provided for @forget_password_sent.
  ///
  /// In en, this message translates to:
  /// **'Sent successfully'**
  String get forget_password_sent;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get something_went_wrong;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully'**
  String get login_success;

  /// No description provided for @create_new_password.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get create_new_password;

  /// No description provided for @password_changed_success.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get password_changed_success;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @invalid_or_expired_link.
  ///
  /// In en, this message translates to:
  /// **'The link is invalid, expired, or has already been used. Please request a new one.'**
  String get invalid_or_expired_link;

  /// No description provided for @unexpected_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpected_error;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get favorites;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @emptyCategories.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get emptyCategories;

  /// No description provided for @defaultError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get defaultError;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Order'**
  String get myOrders;

  /// No description provided for @myFavourites.
  ///
  /// In en, this message translates to:
  /// **'My Favourites'**
  String get myFavourites;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @myCard.
  ///
  /// In en, this message translates to:
  /// **'My Card'**
  String get myCard;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @addtocard.
  ///
  /// In en, this message translates to:
  /// **'Add to Card'**
  String get addtocard;

  /// No description provided for @processtocheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get processtocheckout;

  /// No description provided for @mycart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get mycart;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @availableinstock.
  ///
  /// In en, this message translates to:
  /// **'Available in stock'**
  String get availableinstock;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @reviewsHeader.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get reviewsHeader;

  /// No description provided for @reviewsLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get reviewsLoadingError;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet. Be the first to share your thoughts!'**
  String get noReviewsYet;

  /// No description provided for @addReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get addReviewTitle;

  /// No description provided for @experienceHint.
  ///
  /// In en, this message translates to:
  /// **'How was your experience with this product?'**
  String get experienceHint;

  /// No description provided for @postButton.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get postButton;

  /// No description provided for @errorHappened.
  ///
  /// In en, this message translates to:
  /// **'Error happened!'**
  String get errorHappened;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// No description provided for @noAvailableSizes.
  ///
  /// In en, this message translates to:
  /// **'No available Sizes'**
  String get noAvailableSizes;

  /// No description provided for @noAvailableColors.
  ///
  /// In en, this message translates to:
  /// **'No available Colors'**
  String get noAvailableColors;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @addressAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address added successfully'**
  String get addressAddedSuccessfully;

  /// No description provided for @streetEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Street cannot be empty.'**
  String get streetEmptyDescription;

  /// No description provided for @streetTooShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Street is too short, must be at least 5 characters.'**
  String get streetTooShortDescription;

  /// No description provided for @cityEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'City cannot be empty.'**
  String get cityEmptyDescription;

  /// No description provided for @cityTooShortDescription.
  ///
  /// In en, this message translates to:
  /// **'City is too short, must be at least 2 characters.'**
  String get cityTooShortDescription;

  /// No description provided for @countryEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Country cannot be empty.'**
  String get countryEmptyDescription;

  /// No description provided for @countryTooShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Country is too short, must be at least 2 characters.'**
  String get countryTooShortDescription;

  /// No description provided for @phoneEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Phone number cannot be empty.'**
  String get phoneEmptyDescription;

  /// No description provided for @phoneInvalidDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get phoneInvalidDescription;

  /// No description provided for @phoneLengthDescription.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be between 8 and 15 digits.'**
  String get phoneLengthDescription;
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
