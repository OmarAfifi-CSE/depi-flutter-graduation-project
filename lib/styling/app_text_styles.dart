import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static const TextStyle primaryHeadlineStyle = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitlesStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // Example:
  // for themes
  static const TextStyle whiteTitleMediumTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle blackTitleMediumTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
