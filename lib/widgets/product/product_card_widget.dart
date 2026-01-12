import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends StatelessWidget {
  final String img;
  final String name;
  final String subtitle;
  final double price;
  final double finalPrice;
  final double discountPercentage;

  const ProductCardWidget({
    super.key,
    required this.img,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.finalPrice,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasDiscount = price > finalPrice;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: BuildDynamicImage(imageUrl: img),
                ),
              ),
              if (hasDiscount)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    child: CustomText(
                      data: "${discountPercentage.toInt()}% OFF",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.englishFontFamily,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: name,
              maxLines: 1,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.englishFontFamily,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 2.h),
            CustomText(
              data: subtitle,
              maxLines: 1,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.englishFontFamily,
              color: theme.primaryColor.withValues(alpha: 0.7),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                CustomText(
                  data: "\$${finalPrice.toStringAsFixed(2)}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.englishFontFamily,
                  color: theme.primaryColor,
                ),
                if (hasDiscount) ...[
                  SizedBox(width: 8.w),
                  CustomText(
                    data: "\$${price.toStringAsFixed(2)}",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.englishFontFamily,
                    color: theme.primaryColor.withValues(alpha: 0.7),
                    lined: true,
                    decorationColor: theme.primaryColor.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }
}
