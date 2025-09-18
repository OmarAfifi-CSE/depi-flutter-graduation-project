import 'package:flutter/material.dart';

import 'app_colors.dart';

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
