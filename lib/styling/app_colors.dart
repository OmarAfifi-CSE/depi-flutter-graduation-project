import 'package:flutter/material.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  // Define the colors that will change with the theme
  final Color? textFieldFill;
  final Color? textField;
  final Color? secondaryText;
  final Color? card;
  final Color? containerBorder;

  // Constructor
  const AppColorTheme({
    required this.textFieldFill,
    required this.textField,
    required this.secondaryText,
    required this.card,
    required this.containerBorder,
  });

  // copyWith is required for ThemeExtension
  @override
  AppColorTheme copyWith({
    Color? textFieldFill,
    Color? textField,
    Color? secondaryText,
    Color? card,
    Color? containerBorder,
  }) {
    return AppColorTheme(
      textFieldFill: textFieldFill ?? this.textFieldFill,
      textField: textField ?? this.textField,
      secondaryText: secondaryText ?? this.secondaryText,
      card: card ?? this.card,
      containerBorder: containerBorder ?? this.containerBorder,
    );
  }

  // lerp is required for ThemeExtension
  @override
  AppColorTheme lerp(ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) {
      return this;
    }
    return AppColorTheme(
      textFieldFill: Color.lerp(textFieldFill, other.textFieldFill, t),
      textField: Color.lerp(textField, other.textField, t),
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
      card: Color.lerp(card, other.card, t),
      containerBorder: Color.lerp(containerBorder, other.containerBorder, t),
    );
  }
}
