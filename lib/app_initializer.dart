import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/routing/router_generation_config.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // 5. Load the saved theme from storage.
    final String themeName =
        prefs.getString(ThemeProvider.themeKey) ?? ThemeMode.light.name;
    final initialThemeMode = ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.light,
    );

    // 6. Load the saved locale and configure fonts.
    final String localeCode = prefs.getString(LocaleProvider.localeKey) ?? "en";
    if (localeCode == "ar") {
      AppFonts.mainFontName = "Tajawal";
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
