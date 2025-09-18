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
}
