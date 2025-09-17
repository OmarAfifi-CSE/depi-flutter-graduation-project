import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static TextStyle primaryHeadlineStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subtitlesStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // Example:
  // for themes
  static TextStyle whiteTitleMediumTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle blackTitleMediumTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
