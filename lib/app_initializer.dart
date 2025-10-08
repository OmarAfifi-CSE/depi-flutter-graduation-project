import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/routing/router_generation_config.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import 'firebase_options.dart';

// A simple data class to hold the results from the initialization process.
class InitializationResult {
  final GoRouter router;
  final ThemeMode initialThemeMode;
  final Locale initialLocale;

  InitializationResult({
    required this.router,
    required this.initialThemeMode,
    required this.initialLocale,
  });
}

class AppInitializer {
  // This static method will perform all the async setup and return the results.
  static Future<InitializationResult> initialize() async {
    // 1. Ensure Flutter engine is ready.
    WidgetsFlutterBinding.ensureInitialized();

    // 2. Initialize Firebase.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 3. Initialize SharedPreferences to read saved settings.
    final prefs = await SharedPreferences.getInstance();

    // 4. Create the router instance, passing its dependencies.
    final appRouter = RouterGenerationConfig(sharedPreferences: prefs);

    // 5. Determine the initial theme.
    final String? savedThemeName = prefs.getString(ThemeProvider.themeKey);
    late final ThemeMode initialThemeMode;

    if (savedThemeName != null) {
      initialThemeMode = ThemeMode.values.firstWhere(
        (e) => e.name == savedThemeName,
        orElse: () => ThemeMode.light,
      );
    } else {
      // If no theme is saved, get it from the device's system settings.
      final Brightness platformBrightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      initialThemeMode = platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
      await prefs.setString(ThemeProvider.themeKey, initialThemeMode.name);
    }

    // 6. Determine the initial locale.
    final String? savedLocaleCode = prefs.getString(LocaleProvider.localeKey);
    late final String localeCode;

    if (savedLocaleCode != null) {
      localeCode = savedLocaleCode;
    } else {
      // If no locale is saved, get it from the device's system settings.
      final String systemLocale =
          ui.PlatformDispatcher.instance.locale.languageCode;
      if (systemLocale == 'ar') {
        localeCode = 'ar';
      } else {
        localeCode = 'en';
      }
      await prefs.setString(LocaleProvider.localeKey, localeCode);
    }
    if (localeCode == "ar") {
      AppFonts.mainFontName = AppFonts.arabicFontFamily;
    } else {
      AppFonts.mainFontName = AppFonts.englishFontFamily;
    }
    final initialLocale = Locale(localeCode);

    // 7. Return all the initialized objects.
    return InitializationResult(
      router: appRouter.router,
      initialThemeMode: initialThemeMode,
      initialLocale: initialLocale,
    );
  }
}
