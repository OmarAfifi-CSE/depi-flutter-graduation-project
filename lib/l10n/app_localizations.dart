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

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Sittings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'lan'**
  String get language;

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

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// No description provided for @emailRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Required'**
  String get emailRequiredTitle;

  /// No description provided for @emailRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address to continue'**
  String get emailRequiredDescription;

  /// No description provided for @emailInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get emailInvalidTitle;

  /// No description provided for @emailInvalidDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address format'**
  String get emailInvalidDescription;

  /// No description provided for @passwordRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Required'**
  String get passwordRequiredTitle;

  /// No description provided for @passwordRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password to login'**
  String get passwordRequiredDescription;

  /// No description provided for @passwordTooShortTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Too Short'**
  String get passwordTooShortTitle;

  /// No description provided for @passwordTooShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordTooShortDescription;

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
