import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';
import '../../../styling/app_colors.dart' show AppColorTheme;

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
    if (count > productProvider.currentVariantStock) {
      count = productProvider.currentVariantStock;
    }
    if (count == 0 && productProvider.currentVariantStock > 0) {
      count = 1;
    }
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      alignment: Alignment.center,
      // width: 70.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: appColors.card,
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
              data: productProvider.currentVariantStock != 0
                  ? count.toString()
                  : "0",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            if (productProvider.currentVariantStock != 0)
              GestureDetector(
                onTap: () {
                  if (count < productProvider.currentVariantStock) {
                    setState(() {
                      count++;
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
