import 'package:flutter/material.dart';

import 'app_colors.dart';

// Example:
// class AppThemes {
//   static final lightTheme = ThemeData(
//     scaffoldBackgroundColor: AppColors.whiteColor,
//     primaryColor: AppColors.blackColor,
//     fontFamily: AppFonts.mainFontName,
//
//     textTheme: TextTheme(
//       titleLarge: AppTextStyles.primaryHeadlineStyle,
//       titleMedium: AppTextStyles.blackTitleMediumTextStyle,
//     ),
//
//     buttonTheme: const ButtonThemeData(
//       buttonColor: AppColors.whiteColor,
//       disabledColor: AppColors.whiteColor,
//     ),
//
//     colorScheme: ColorScheme.fromSwatch().copyWith(
//       primary: AppColors.cardColor,
//     ),
//
//     splashColor: Colors.transparent,
//     highlightColor: Colors.transparent,
//     hoverColor: Colors.transparent,
//   );
//
//   // ---------------------------------------------------------
//
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor: AppColors.blackColor,
//     primaryColor: AppColors.whiteColor,
//     fontFamily: AppFonts.mainFontName,
//
//     colorScheme: const ColorScheme.dark(
//       primary: AppColors.whiteColor,
//       secondary: Colors.tealAccent,
//       brightness: Brightness.dark,
//     ),
//
//     textTheme: TextTheme(
//       titleLarge: AppTextStyles.primaryHeadlineStyle.copyWith(
//         color: Colors.white,
//       ),
//       titleMedium: AppTextStyles.whiteTitleMediumTextStyle,
//     ),
//     buttonTheme: const ButtonThemeData(
//       buttonColor: AppColors.whiteColor,
//       disabledColor: AppColors.blackColor,
//     ),
//
//     splashColor: Colors.transparent,
//     highlightColor: Colors.transparent,
//     hoverColor: Colors.transparent,
//   );
// }

// In your app_themes.dart file
// Make sure to import your new AppColorTheme class

// lib/themes/app_themes.dart

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    // Add the extension with your LIGHT theme colors
    extensions: const <ThemeExtension<dynamic>>[
      AppColorTheme(
        textFieldFill: Color(0xffF3F4F5),
        textField: Color(0xffAAAAAA),
        secondaryText: Color(0xff666666),
        card: Color(0xffDDDDDD),
        containerBorder: Color(0xff888888),
      ),
    ],
  );

  // ---------------------------------------------------------

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,

    // Add the extension with your DARK theme colors
    extensions: const <ThemeExtension<dynamic>>[
      AppColorTheme(
        textFieldFill: Color(0xff2A2A2A),
        textField: Color(0xff777777),
        secondaryText: Color(0xffCCCCCC),
        card: Color(0xff1E1E1E),
        containerBorder: Color(0xff555555),
      ),
    ],
  );
}