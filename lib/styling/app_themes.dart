import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_text_styles.dart';
// Example:
class AppThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey[600],
      backgroundColor: AppColors.primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    primaryColor: AppColors.primaryColor,
    fontFamily: AppFonts.mainFontName,

    textTheme: const TextTheme(
      titleLarge: AppTextStyles.primaryHeadlineStyle,
      titleMedium: AppTextStyles.blackTitleMediumTextStyle,
    ),

    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.secondaryColor,
    ),

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
    ).copyWith(secondary: Colors.white),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  // ---------------------------------------------------------

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey[600],
      backgroundColor: AppColors.secondaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    primaryColor: AppColors.primaryColor,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: Colors.tealAccent,
      brightness: Brightness.dark,
    ),

    textTheme: TextTheme(
      titleLarge: AppTextStyles.primaryHeadlineStyle.copyWith(
        color: Colors.white,
      ),
      titleMedium: AppTextStyles.whiteTitleMediumTextStyle,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.secondaryColor,
    ),

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );
}
