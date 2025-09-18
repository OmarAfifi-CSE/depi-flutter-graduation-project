import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.data,
    required this.fontSize,
    required this.fontWeight,
    this.color,
  });

  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: AppFonts.mainFontName,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
