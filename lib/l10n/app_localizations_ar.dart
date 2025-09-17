// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get test => 'جرب';

  @override
  String get hello => 'أهلاً';

  @override
  String get welcome => 'أهلاً بك في تطبيقنا';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String userName(Object name) {
    return 'أهلاً $name!';
  }
}
