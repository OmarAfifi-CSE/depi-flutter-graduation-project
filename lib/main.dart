import 'package:batrina/app_initializer.dart';
import 'package:batrina/controllers/cubit/auth/auth_cubit/auth_cubit.dart';
import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/styling/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:batrina/l10n/app_localizations.dart';

void main() async {
  final InitializationResult result = await AppInitializer.initialize();

  runApp(
    MyApp(
      initialThemeMode: result.initialThemeMode,
      initialLocale: result.initialLocale,
      router: result.router,
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeMode initialThemeMode;
  final Locale initialLocale;
  final GoRouter router;

  const MyApp({
    super.key,
    this.initialThemeMode = ThemeMode.light,
    required this.initialLocale,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(initialThemeMode)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(initialLocale)),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => GetCartCubit()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) =>
            ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return MaterialApp.router(
                  builder: (context, child) {
                    context.read<AuthCubit>().loc = AppLocalizations.of(
                      context,
                    );
                    return child!;
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
                  routerConfig: router,
                );
              },
            ),
      ),
    );
  }
}
