import 'package:batrina/controllers/provider/control_rating_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/product/reviews_screen.dart';
import 'package:batrina/views/product/widgets/counter.dart';
import 'package:batrina/views/product/widgets/product_selection.dart';
import 'package:batrina/views/product/widgets/size_option.dart';
import 'package:batrina/views/product/widgets/stars.dart';
import 'package:batrina/views/product/widgets/stock_count_text.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../styling/app_colors.dart';
import 'add_to_cart_button.dart';

class ProductOptions extends StatelessWidget {
  const ProductOptions({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
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
                  ),
                ),
                SizedBox(height: 4.h),
                CustomText(
                  data: productModel.subtitle,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: appColors.secondaryText,
                ),
                SizedBox(height: 4.h),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.reviewsScreen,
                      extra: productModel,
                    );
                  },
                  child: Consumer<ControlRatingProvider>(
                    builder: (context, value, child) {
                      print("hasasasasasa");
                      print(value.currentRating);
                      print(value.currentRatingCount);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stars(numberOfStart: value.currentRating.round()),
                          SizedBox(width: 4.w),
                          CustomText(
                            data: "(${value.currentRatingCount} Reviews)",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      );
                    },
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
        CustomText(data: "Size", fontSize: 17.sp, fontWeight: FontWeight.w700),
        SizedBox(height: 17.h),
        ProductSelection(productModel: productModel),
        SizedBox(height: 27.h),
        CustomText(
          data: "Description",
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
