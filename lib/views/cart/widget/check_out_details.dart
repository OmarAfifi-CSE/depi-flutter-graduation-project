import 'package:flutter/material.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutDetails extends StatelessWidget {
  const CheckOutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);

    return Container(
      padding:  const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border:  Border.all(color: appColors.containerBorder!, width: .5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: loc!.subtotal,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const CustomText(
                data: '\$200',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(height: 1.h,color:theme.dividerColor),
          SizedBox(height: 12.h),

          // Shipping
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: loc.shipping,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const CustomText(
                data: '\$4888',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Divider
          Container(height: 1.h, color:theme.dividerColor),
          SizedBox(height: 16.h),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: loc.total,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  CustomText(
                    data: '(3 ${loc.items} )',
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 8.w),
                  const CustomText(
                    data: '\$5000',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
