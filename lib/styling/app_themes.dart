import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_text_styles.dart';

// Example:
class AppThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    primaryColor: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,

    textTheme: TextTheme(
      titleLarge: AppTextStyles.primaryHeadlineStyle,
      titleMedium: AppTextStyles.blackTitleMediumTextStyle,
    ),

    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.whiteColor,
      disabledColor: AppColors.whiteColor,
    ),

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
    ).copyWith(secondary: Colors.white),

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  // ---------------------------------------------------------

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    primaryColor: AppColors.whiteColor,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.whiteColor,
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
      buttonColor: AppColors.whiteColor,
      disabledColor: AppColors.blackColor,
    ),

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );
}
