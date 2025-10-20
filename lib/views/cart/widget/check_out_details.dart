import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/views/cart/widget/price_row.dart';
import 'package:flutter/material.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutDetails extends StatelessWidget {
  const CheckOutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CartPriceProvider cartPriceProvider = context
        .watch<CartPriceProvider>();
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.dividerColor!, width: 1.r),
      ),
      child: Column(
        children: [
          // Subtotal
          PriceRow(
            title: loc!.subtotal,
            suffix: CustomText(
              data: '\$${cartPriceProvider.subTotal}',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 15.h,
            child: Divider(color: appColors.dividerColor, thickness: 1.h, height: 1.h),
          ),

          // Shipping
          PriceRow(
            title: loc.shipping,
            suffix: CustomText(
              data: '\$${cartPriceProvider.currentShipping}',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.h,
            child: Divider(color: appColors.dividerColor, thickness: 1.h, height: 1.h),
          ),

          // Total
          PriceRow(
            title: loc.total,
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  data: '(${cartPriceProvider.count} ${loc.items} )',
                  fontSize: 13.sp,
                  color: appColors.containerBorder,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 8.w),
                CustomText(
                  data: '\$${cartPriceProvider.total}',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
