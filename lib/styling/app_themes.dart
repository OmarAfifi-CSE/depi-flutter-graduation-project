import 'package:flutter/material.dart';

import 'package:batrina/styling/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    cardColor: const Color(0xffDDDDDD),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    // Add the extension with your LIGHT theme colors
    extensions: const <ThemeExtension<dynamic>>[
      AppColorTheme(
        textFieldFill: Color(0xffF3F4F5),
        textField: Color(0xffAAAAAA),
        secondaryText: Color(0xff666666),
        card: Color(0xffdddddd),
        containerBorder: Color(0xff888888),
        countButtonBackground: Color(0xffEEEEEE),
      ),
    ],
  );

  // ---------------------------------------------------------

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    cardColor: const Color(0xff1E1E1E),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    // Add the extension with your DARK theme colors
    extensions: const <ThemeExtension<dynamic>>[
      AppColorTheme(
        textFieldFill: Color(0xff2A2A2A),
        textField: Color(0xff777777),
        secondaryText: Color(0xffCCCCCC),
        card: Color(0xff1E1E1E),
        containerBorder: Color(0xff555555),
        countButtonBackground: Color(0xFF424242),
      ),
    ],
  );
}
