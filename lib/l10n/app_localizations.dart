import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh')
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

  /// No description provided for @couldNotLoadCategories.
  ///
  /// In en, this message translates to:
  /// **'Could not load categories'**
  String get couldNotLoadCategories;

  /// No description provided for @defaultError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get defaultError;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboard;

  /// No description provided for @activeEditingMode.
  ///
  /// In en, this message translates to:
  /// **'Active Editing Mode'**
  String get activeEditingMode;

  /// No description provided for @viewAsCustomer.
  ///
  /// In en, this message translates to:
  /// **'View as Customer'**
  String get viewAsCustomer;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

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

  /// No description provided for @emptyCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Cart is Empty'**
  String get emptyCartTitle;

  /// No description provided for @emptyCartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added anything to your cart yet. Let\'s go find something you\'ll love!'**
  String get emptyCartSubtitle;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

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

  /// No description provided for @removeFromCart.
  ///
  /// In en, this message translates to:
  /// **'Remove from cart'**
  String get removeFromCart;

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

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Product added to cart'**
  String get productAddedToCart;

  /// No description provided for @productRemovedFromCart.
  ///
  /// In en, this message translates to:
  /// **'Product removed from cart'**
  String get productRemovedFromCart;

  /// No description provided for @shippingAddresses.
  ///
  /// In en, this message translates to:
  /// **'Shipping Addresses'**
  String get shippingAddresses;

  /// No description provided for @mainAddress.
  ///
  /// In en, this message translates to:
  /// **'Main Address'**
  String get mainAddress;

  /// No description provided for @noMainAddress.
  ///
  /// In en, this message translates to:
  /// **'No Main Address'**
  String get noMainAddress;

  /// No description provided for @dragAnAddress.
  ///
  /// In en, this message translates to:
  /// **'Drag an address up to set it as main.'**
  String get dragAnAddress;

  /// No description provided for @otherAddresses.
  ///
  /// In en, this message translates to:
  /// **'Other Addresses'**
  String get otherAddresses;

  /// No description provided for @setMain.
  ///
  /// In en, this message translates to:
  /// **'Set Main'**
  String get setMain;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @tapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap to add'**
  String get tapToAdd;

  /// No description provided for @swipeToManage.
  ///
  /// In en, this message translates to:
  /// **'Swipe to manage'**
  String get swipeToManage;

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

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @ratting.
  ///
  /// In en, this message translates to:
  /// **'Ratting'**
  String get ratting;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get noProductsFound;

  /// No description provided for @filteredProducts.
  ///
  /// In en, this message translates to:
  /// **'Filtered Products'**
  String get filteredProducts;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @selectDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Select Delivery Address'**
  String get selectDeliveryAddress;

  /// No description provided for @noAddressFound.
  ///
  /// In en, this message translates to:
  /// **'No Address Found'**
  String get noAddressFound;

  /// No description provided for @pleaseAddAddress.
  ///
  /// In en, this message translates to:
  /// **'Please add an address to proceed.'**
  String get pleaseAddAddress;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order Placed!'**
  String get orderPlacedSuccessfully;

  /// No description provided for @orderSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your order will be delivered soon.\nThank you for shopping with us!'**
  String get orderSuccessSubtitle;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @trackYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Track Your Order'**
  String get trackYourOrder;

  /// No description provided for @orderFailedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again.'**
  String get orderFailedError;

  /// No description provided for @nothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing Found'**
  String get nothingFound;

  /// No description provided for @emptyCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any products in the \'{categoryName}\' category right now. Try checking back later or exploring other categories.'**
  String emptyCategoryDescription(Object categoryName);

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add New Category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @enterCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get enterCategoryName;

  /// No description provided for @isActive.
  ///
  /// In en, this message translates to:
  /// **'Is Active'**
  String get isActive;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get fillAllFields;

  /// No description provided for @reorderCategories.
  ///
  /// In en, this message translates to:
  /// **'Reorder Categories'**
  String get reorderCategories;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @areYouSureToSaveCategoryOrder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to save the new order of categories?'**
  String get areYouSureToSaveCategoryOrder;

  /// No description provided for @categoryOrderUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Category order updated successfully'**
  String get categoryOrderUpdatedSuccessfully;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// No description provided for @areYouSureToDeleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category? This action cannot be undone.'**
  String get areYouSureToDeleteCategory;

  /// No description provided for @categoryDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Category deleted successfully'**
  String get categoryDeletedSuccessfully;

  /// No description provided for @categorySavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Category saved successfully'**
  String get categorySavedSuccessfully;

  /// No description provided for @newChatRequest.
  ///
  /// In en, this message translates to:
  /// **'New chat request'**
  String get newChatRequest;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @typing.
  ///
  /// In en, this message translates to:
  /// **'typing...'**
  String get typing;

  /// No description provided for @noConnection.
  ///
  /// In en, this message translates to:
  /// **'No Connection'**
  String get noConnection;

  /// No description provided for @sayHi.
  ///
  /// In en, this message translates to:
  /// **'Say hi!'**
  String get sayHi;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type Message...'**
  String get typeMessage;

  /// No description provided for @searchByEmail.
  ///
  /// In en, this message translates to:
  /// **'Search by email to start a new chat'**
  String get searchByEmail;

  /// No description provided for @chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// No description provided for @newUsers.
  ///
  /// In en, this message translates to:
  /// **'New Users'**
  String get newUsers;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @noNewUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No New Users Found'**
  String get noNewUsersFound;

  /// No description provided for @startNewChat.
  ///
  /// In en, this message translates to:
  /// **'Start a new chat'**
  String get startNewChat;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @chatsTab.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chatsTab;

  /// No description provided for @requestsTab.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTab;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @secondsAgo.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s ago'**
  String secondsAgo(Object seconds);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(Object minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(Object hours);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(Object days);

  /// No description provided for @noChatsYet.
  ///
  /// In en, this message translates to:
  /// **'No chats yet'**
  String get noChatsYet;

  /// No description provided for @noRequestsYet.
  ///
  /// In en, this message translates to:
  /// **'No requests yet'**
  String get noRequestsYet;

  /// No description provided for @youRestricted.
  ///
  /// In en, this message translates to:
  /// **'You restricted this user'**
  String get youRestricted;

  /// No description provided for @youRestrictedBy.
  ///
  /// In en, this message translates to:
  /// **'You\'re restricted by this user'**
  String get youRestrictedBy;

  /// No description provided for @moveToChats.
  ///
  /// In en, this message translates to:
  /// **'Unblock & move to chats'**
  String get moveToChats;

  /// No description provided for @restrictedTab.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get restrictedTab;

  /// No description provided for @noRestrictedYet.
  ///
  /// In en, this message translates to:
  /// **'No blocked users'**
  String get noRestrictedYet;

  /// No description provided for @sendTo.
  ///
  /// In en, this message translates to:
  /// **'Send to...'**
  String get sendTo;

  /// No description provided for @shareToOtherApps.
  ///
  /// In en, this message translates to:
  /// **'Share to other apps'**
  String get shareToOtherApps;

  /// No description provided for @moveToRequests.
  ///
  /// In en, this message translates to:
  /// **'Move to Requests'**
  String get moveToRequests;

  /// No description provided for @moveToRestricted.
  ///
  /// In en, this message translates to:
  /// **'move to restricted'**
  String get moveToRestricted;

  /// No description provided for @areYouSureToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get areYouSureToLogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @failedToLogout.
  ///
  /// In en, this message translates to:
  /// **'Failed to log out: \'{errorMessage}\''**
  String failedToLogout(Object errorMessage);

  /// No description provided for @pleaseEnterUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter a URL'**
  String get pleaseEnterUrl;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get invalidUrl;

  /// No description provided for @pasteImagesUrl.
  ///
  /// In en, this message translates to:
  /// **'Paste image URLs'**
  String get pasteImagesUrl;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @addSize.
  ///
  /// In en, this message translates to:
  /// **'Add size'**
  String get addSize;

  /// No description provided for @addNumber.
  ///
  /// In en, this message translates to:
  /// **'Add number'**
  String get addNumber;

  /// No description provided for @addStock.
  ///
  /// In en, this message translates to:
  /// **'Add stock'**
  String get addStock;

  /// No description provided for @selectSize.
  ///
  /// In en, this message translates to:
  /// **'Select size'**
  String get selectSize;

  /// No description provided for @selectNumber.
  ///
  /// In en, this message translates to:
  /// **'Select number'**
  String get selectNumber;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @enterQuantity.
  ///
  /// In en, this message translates to:
  /// **'Enter quantity'**
  String get enterQuantity;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose...'**
  String get choose;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @addImageFrom.
  ///
  /// In en, this message translates to:
  /// **'Add image from'**
  String get addImageFrom;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @urlLink.
  ///
  /// In en, this message translates to:
  /// **'URL link'**
  String get urlLink;

  /// No description provided for @productThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Product thumbnail'**
  String get productThumbnail;

  /// No description provided for @mainImage.
  ///
  /// In en, this message translates to:
  /// **'Main image (Cover)'**
  String get mainImage;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @productColors.
  ///
  /// In en, this message translates to:
  /// **'Product Colors'**
  String get productColors;

  /// No description provided for @addNewColor.
  ///
  /// In en, this message translates to:
  /// **'Add New Color'**
  String get addNewColor;

  /// No description provided for @enterProductName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get enterProductName;

  /// No description provided for @productNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Product name is required'**
  String get productNameRequired;

  /// No description provided for @productNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Product name must be at least 3 characters'**
  String get productNameMinLength;

  /// No description provided for @enterSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Product subTitle'**
  String get enterSubTitle;

  /// No description provided for @subTitle.
  ///
  /// In en, this message translates to:
  /// **'subTitle'**
  String get subTitle;

  /// No description provided for @subtitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Subtitle is required'**
  String get subtitleRequired;

  /// No description provided for @subtitleMinLength.
  ///
  /// In en, this message translates to:
  /// **'Subtitle must be at least 2 characters'**
  String get subtitleMinLength;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Product Description'**
  String get enterDescription;

  /// No description provided for @descriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionRequired;

  /// No description provided for @descriptionMinLength.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 10 characters'**
  String get descriptionMinLength;

  /// No description provided for @enterPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter Price'**
  String get enterPrice;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @priceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get priceRequired;

  /// No description provided for @pleaseEnterValidPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get pleaseEnterValidPrice;

  /// No description provided for @priceGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Price must be greater than 0'**
  String get priceGreaterThanZero;

  /// No description provided for @errorFetchingCategories.
  ///
  /// In en, this message translates to:
  /// **'Error while fetching categories'**
  String get errorFetchingCategories;

  /// No description provided for @sizesAndStock.
  ///
  /// In en, this message translates to:
  /// **'Sizes & Stock'**
  String get sizesAndStock;

  /// No description provided for @noSizesAdded.
  ///
  /// In en, this message translates to:
  /// **'No sizes added yet.'**
  String get noSizesAdded;

  /// No description provided for @pleaseAddColorsFirst.
  ///
  /// In en, this message translates to:
  /// **'Please add colors first to manage variants.'**
  String get pleaseAddColorsFirst;

  /// No description provided for @manageStockAndSizes.
  ///
  /// In en, this message translates to:
  /// **'Manage Stock & Sizes'**
  String get manageStockAndSizes;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @productAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully'**
  String get productAddedSuccessfully;

  /// No description provided for @productEditedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product edited successfully'**
  String get productEditedSuccessfully;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @areYouSureToDeleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product? This action cannot be undone.'**
  String get areYouSureToDeleteProduct;

  /// No description provided for @productDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product deleted successfully'**
  String get productDeletedSuccessfully;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// No description provided for @yourWishlistIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your wishlist is empty'**
  String get yourWishlistIsEmpty;

  /// No description provided for @wishlistEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added anything to your wishlist yet. Let\'s go find something you\'ll love!'**
  String get wishlistEmptyMessage;

  /// No description provided for @noItemsMatchSearch.
  ///
  /// In en, this message translates to:
  /// **'No items match your search'**
  String get noItemsMatchSearch;

  /// No description provided for @itemAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Item added to cart!'**
  String get itemAddedToCart;

  /// No description provided for @itemRemovedFromCart.
  ///
  /// In en, this message translates to:
  /// **'Item removed from cart'**
  String get itemRemovedFromCart;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @productNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this product is no longer available. Let\'s go find something else you\'ll love!'**
  String get productNotFoundMessage;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'es', 'fr', 'hi', 'it', 'ja', 'ko', 'pt', 'ru', 'tr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'hi': return AppLocalizationsHi();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'pt': return AppLocalizationsPt();
    case 'ru': return AppLocalizationsRu();
    case 'tr': return AppLocalizationsTr();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
