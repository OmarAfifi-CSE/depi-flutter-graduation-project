import 'package:flutter/material.dart';
import 'package:batrina/styling/app_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.data,
    required this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.color,
    this.maxLines,
    this.forceStrutHeight = false,
    this.lined = false,
    this.decorationColor,
  });

  final String data;
  final double fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool lined;
  final Color? decorationColor;

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
        decoration: lined ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: decorationColor,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? AppFonts.mainFontName,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
