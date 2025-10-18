import 'package:flutter/material.dart';
import 'package:batrina/styling/app_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.data,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.color,
    this.maxLines,
    this.fontFamily,
    this.forceStrutHeight = false,
  });

  final String? fontFamily;
  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  // Sometimes Arabic text appears slightly higher than adjacent text
  final bool forceStrutHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      strutStyle: forceStrutHeight
          ? const StrutStyle(forceStrutHeight: true)
          : null,

      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? AppFonts.mainFontName,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
