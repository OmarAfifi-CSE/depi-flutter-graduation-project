import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../number_localizer.dart';

class Counter extends StatefulWidget {
  const Counter({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final localeCode = Localizations.localeOf(context).languageCode;

    if (count > productProvider.currentVariantStock) {
      count = productProvider.currentVariantStock;
    }
    if (count == 0 && productProvider.currentVariantStock > 0) {
      count = 1;
    }
    productProvider.quantity = count;
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      alignment: Alignment.center,
      height: 30.h,
      decoration: BoxDecoration(
        color: appColors.countButtonBackground,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
        child: Row(
          spacing: 13.w,
          mainAxisAlignment: productProvider.currentVariantStock != 0
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (productProvider.currentVariantStock != 0)
              GestureDetector(
                onTap: () {
                  if (count > 1) {
                    setState(() {
                      count--;
                      productProvider.quantity = count;
                    });
                  }
                },
                child: Icon(
                  Icons.remove,
                  color: theme.primaryColor,
                  size: 16.sp,
                ),
              ),
            CustomText(
              forceStrutHeight: true,
              data: NumberLocalizer.formatNumber(
                productProvider.currentVariantStock != 0
                    ? count.toString()
                    : "0",
                localeCode,
              ),

              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            if (productProvider.currentVariantStock != 0)
              GestureDetector(
                onTap: () {
                  if (count < productProvider.currentVariantStock) {
                    setState(() {
                      count++;
                      productProvider.quantity = count;
                    });
                  }
                },
                child: Icon(Icons.add, color: theme.primaryColor, size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }
}
