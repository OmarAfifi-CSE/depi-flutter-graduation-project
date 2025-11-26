import 'package:batrina/models/cart_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  final CartModel cartModel;

  const ProductCard({super.key, required this.cartModel});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      height: 95.h,
      padding: EdgeInsets.all(12.0.w),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.15),
            blurRadius: 10.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(12.r),
                clipBehavior: Clip.antiAlias,
                child: BuildDynamicImage(imageUrl: widget.cartModel.thumbnail),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    data: widget.cartModel.productName,
                    textAlign: TextAlign.start,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    fontFamily: AppFonts.englishFontFamily,
                  ),
                  CustomText(
                    data: widget.cartModel.subtitle,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.secondaryText,
                    maxLines: 1,
                    fontFamily: AppFonts.englishFontFamily,
                  ),
                  const Spacer(),
                  CustomText(
                    data: "\$${widget.cartModel.price}",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.englishFontFamily,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 6.h),
                _buildSizeOption(),
                SizedBox(height: 4.h),
                _buildColorOption(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOption() {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      width: widget.cartModel.size != "Standard" ? 20.w : 70.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: widget.cartModel.size != "Standard"
            ? BoxShape.circle
            : BoxShape.rectangle,
        color: theme.primaryColor,
        border: Border.all(color: appColors.containerBorder!),
      ),
      child: Center(
        child: CustomText(
          data: widget.cartModel.size != "Standard"
              ? widget.cartModel.size
              : "Standard",
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: theme.scaffoldBackgroundColor,
          fontFamily: AppFonts.englishFontFamily,
        ),
      ),
    );
  }

  Widget _buildColorOption() {
    // Colors for LIGHT product variants
    const Color lightCheckmark = Colors.black87;
    final Color lightBorder = Colors.black.withValues(alpha: 0.2);
    final Color lightShadow = Colors.black.withValues(alpha: 0.15);

    // Colors for DARK product variants
    const Color darkCheckmark = Colors.white;
    final Color darkBorder = Colors.white.withValues(alpha: 0.3);
    final Color darkShadow = Colors.black.withValues(alpha: 0.2);
    final productColor = widget.cartModel.colorWidget;
    // Check its luminance (0.0 = black, 1.0 = white)
    final bool isLightColor = productColor.computeLuminance() > 0.5;

    final Color checkmarkColor = isLightColor ? lightCheckmark : darkCheckmark;
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
      child: Center(
        child: Icon(Icons.check, color: checkmarkColor, size: 14.sp),
      ),
    );
  }
}
