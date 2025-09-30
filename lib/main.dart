import 'package:batrina/add_some_products.dart';
import 'package:batrina/app_initializer.dart';
import 'package:batrina/controllers/cubit/auth/auth_cubit/auth_cubit.dart';
import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_themes.dart';
import 'package:batrina/views/product/product_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

late ProductModel pr;

void main() async {
  final InitializationResult result = await AppInitializer.initialize();

  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  List<ProductModel> prds = await fireBaseFireStore.getCategoriesProduct(
    "Clothing",
  );
  pr = prds[2];
  print(pr);
  print(pr.availableColors.length);

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
                  routerConfig: router,
                  // home: ProductScreen(productModel: pr),
                );
              },
            ),
      ),
    );
  }
}
