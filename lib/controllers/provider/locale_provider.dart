import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const _localeKey = "loc";

  static String get localeKey => _localeKey;
  Locale _locale;

  Locale get locale => _locale;

  LocaleProvider(this._locale);

  Future setLocale(String localeName) async {
    if (AppLocalizations.supportedLocales.contains(localeName)) {
      return;
    }
    if (localeName == "ar") {
      AppFonts.mainFontName = AppFonts.arabicFontFamily;
      _locale = const Locale("ar");
      notifyListeners();
    } else {
      AppFonts.mainFontName = AppFonts.englishFontFamily;
      _locale = Locale(localeName);
      notifyListeners();
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      await sharedPreferences.setString(_localeKey, localeName);
    } catch (e) {
      debugPrint("error while saving locale");
    }
  }
}
