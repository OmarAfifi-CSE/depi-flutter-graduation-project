import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends StatelessWidget {
  final String img;
  final String name;
  final String subtitle;
  final double price;

  const ProductCardWidget({
    super.key,
    required this.img,
    required this.name,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Material(
            // This provides the high-performance clipping
            borderRadius: BorderRadius.circular(12.r),
            clipBehavior: Clip.antiAlias, // This is the key property
            child: BuildDynamicImage(imageUrl: img),
          ),
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            CustomText(
              data: name,
              maxLines: 1,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.englishFontFamily,
            ),
            CustomText(
              data: subtitle,
              maxLines: 1,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.englishFontFamily,
            ),
            CustomText(
              data: "$price\$",
              maxLines: 1,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.englishFontFamily,
            ),
          ],
        ),
      ],
    );
  }
}
