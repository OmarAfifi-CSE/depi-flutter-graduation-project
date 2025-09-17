import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static List<String> supporterLocales = const ["ar", "en"];
  static const _localeKey = "loc";
  static String get localeKey => _localeKey;
  Locale _locale;
  Locale get locale => _locale;
  LocaleProvider(this._locale);
  Future setLocale(String localeName) async {
    if (!supporterLocales.contains(localeName)) {
      return;
    }
    _locale = Locale(localeName);
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      await sharedPreferences.setString(_localeKey, localeName);
    } catch (e) {
      debugPrint("error while saving locale");
    }
  }

  void changeLocale(String localeName) {
    if (localeName == "ar") {
      print("dsdsds");
      AppFonts.mainFontName = "Tajawal";

      _locale = const Locale("ar");
      notifyListeners();
      return;
    }
    AppFonts.mainFontName = "Poppins";
    _locale = const Locale("en");
    notifyListeners();
  }
}
