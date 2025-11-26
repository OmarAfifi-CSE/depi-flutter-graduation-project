import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({Key? key, required this.productColor}) : super(key: key);
  final Color productColor;

  @override
  Widget build(BuildContext context) {
    final Color lightBorder = Colors.black.withValues(alpha: 0.2);
    final Color lightShadow = Colors.black.withValues(alpha: 0.15);

    // Colors for DARK product variants

    final Color darkBorder = Colors.white.withValues(alpha: 0.3);
    final Color darkShadow = Colors.black.withValues(alpha: 0.2);
    final bool isLightColor = productColor.computeLuminance() > 0.5;

    final Color borderColor = isLightColor ? lightBorder : darkBorder;
    final Color shadowColor = isLightColor ? lightShadow : darkShadow;
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: productColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 2, spreadRadius: 1),
        ],
      ),
    );
  }
}
