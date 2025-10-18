import 'package:animations/animations.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/product/reviews_screen.dart';
import 'package:batrina/views/product/widgets/add_to_cart_button.dart';
import 'package:batrina/views/product/widgets/counter.dart';
import 'package:batrina/views/product/widgets/product_selection.dart';
import 'package:batrina/views/product/widgets/stars.dart';
import 'package:batrina/views/product/widgets/stock_count_text.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/number_localizer.dart';
import 'package:batrina/styling/app_fonts.dart';

class ProductOptions extends StatelessWidget {
  const ProductOptions({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 180.w,
                  child: CustomText(
                    textAlign: TextAlign.start,
                    data: productModel.name,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.englishFontFamily,
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: 180.w,
                  child: CustomText(
                    data: productModel.subtitle,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    color: appColors.secondaryText,
                    fontFamily: AppFonts.englishFontFamily,
                  ),
                ),
                SizedBox(height: 4.h),
                GestureDetector(
                  onTap: () {
                    final productProvider = context.read<ProductProvider>();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 700),
                        reverseTransitionDuration: const Duration(
                          milliseconds: 700,
                        ),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ChangeNotifierProvider.value(
                            value: productProvider,
                            child: const ReviewsScreen(),
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return SharedAxisTransition(
                                transitionType:
                                    SharedAxisTransitionType.horizontal,
                                animation: animation,
                                secondaryAnimation: secondaryAnimation,
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stars(numberOfStart: productModel.rating!.round()),
                      SizedBox(width: 4.w),
                      CustomText(
                        forceStrutHeight: true,
                        data:
                            "( ${NumberLocalizer.formatNumber(productModel.reviewsCount, Localizations.localeOf(context).languageCode)} ${loc!.reviews} )",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Counter(productModel: productModel),

                SizedBox(height: 13.h),
                const StockCountText(),
              ],
            ),
          ],
        ),
        SizedBox(height: 30.h),
        CustomText(
          data: loc.size,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 17.h),
        ProductSelection(productModel: productModel),
        SizedBox(height: 27.h),
        CustomText(
          data: loc.description,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 20.h),
        CustomText(
          data: productModel.description,
          textAlign: TextAlign.start,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: appColors.secondaryText,
        ),
        SizedBox(height: 28.h),
        AddToCartButton(productModel: productModel),
      ],
    );
  }
}
