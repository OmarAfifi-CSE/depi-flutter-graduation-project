import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../l10n/app_localizations.dart';
import '../../../styling/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productModel});

  final ProductModel productModel;

  void addToCart() {}

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),

      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadiusGeometry.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            data: "\$${productModel.price}",
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: theme.scaffoldBackgroundColor,
          ),
          SizedBox(
            height: 40.h,
            width: 160.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                backgroundColor: theme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12.r),
                ),
              ),
              onPressed: productProvider.currentVariantStock != 0
                  ? addToCart
                  : () {},
              child: productProvider.currentVariantStock != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          AppAssets.cartIcon2,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            theme.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        CustomText(
                          data: loc!.addToCart,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )
                  : Center(
                      child: CustomText(
                        data: loc!.notAvailable,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
