import 'dart:convert';

import 'package:batrina/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:batrina/controllers/cubit/create_new_password_cubit/create_new_password_cubit.dart';
import 'package:batrina/controllers/cubit/forget_password_cubit/forget_password__cubit.dart';
import 'package:batrina/controllers/cubit/nav_control/nav_control_cubit.dart';
import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/routing/router_generation_config.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/styling/app_themes.dart';
import 'package:batrina/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // --- Firebase Initialization ---
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // --- 1. Load Saved Theme ---
  final prefs = await SharedPreferences.getInstance();
  final String themeName =
      prefs.getString(ThemeProvider.themeKey) ?? ThemeMode.light.name;
  final String locale = prefs.getString(LocaleProvider.localeKey) ?? "en";
  if (locale == "ar") {
    AppFonts.mainFontName = "Tajawal";
  }

  if (prefs.getString(UserModel.lastUserKey) != null) {
    // RouterGenerationConfig.initialLoc = AppRoutes.signInScreen;
    UserModel lastUser = UserModel.fromJson(
      jsonDecode(prefs.getString(UserModel.lastUserKey)!),
    );
    FireBaseFireStore.currentUser = lastUser;
  }
  final initialThemeMode = ThemeMode.values.firstWhere(
    (e) => e.name == themeName,
    orElse: () => ThemeMode.light,
  );

  runApp(
    MyApp(initialThemeMode: initialThemeMode, initialLocale: Locale(locale)),
  );
}

class MyApp extends StatelessWidget {
  final ThemeMode initialThemeMode;
  final Locale initialLocale;

  const MyApp({
    super.key,
    this.initialThemeMode = ThemeMode.light,
    required this.initialLocale,
  });

  @override
  Widget build(BuildContext context) {
    // final router = RouterGenerationConfig.goRouter();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(initialThemeMode)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(initialLocale)),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ForgetPasswordCubit()),
        BlocProvider(create: (_) => CreateNewPasswordCubit()),
        BlocProvider(create: (_) => NavControlCubit()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) => ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (_, child) {
            return MaterialApp(
              builder: (context, child) {
                context.read<AuthCubit>().loc = AppLocalizations.of(context);
                context.read<ForgetPasswordCubit>().loc = AppLocalizations.of(
                  context,
                );
                return Stack(
                  children: [
                    ?child,
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (themeProvider.themeMode == ThemeMode.dark) {
                            context.read<ThemeProvider>().setTheme(
                              ThemeMode.light,
                            );
                          } else {
                            context.read<ThemeProvider>().setTheme(
                              ThemeMode.dark,
                            );
                          }
                          if (localeProvider.locale.languageCode != "ar") {
                            context.read<LocaleProvider>().setLocale("ar");
                          } else {
                            context.read<LocaleProvider>().setLocale("en");
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.test),
                      ),
                    ),
                  ],
                );
              },
              supportedLocales: const [Locale("ar"), Locale("en")],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              themeAnimationDuration: const Duration(milliseconds: 500),
              themeAnimationCurve: Curves.easeInOut,
              locale: localeProvider.locale,
              title: 'Batrina',
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeProvider.themeMode,
              //routerConfig: RouterGenerationConfig.router,
              home: const CustomNavBar(),
            );
          },
        ),
      ),
    );
  }
}
