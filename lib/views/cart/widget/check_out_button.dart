import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/controllers/provider/open_details_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/cart/widget/price_row.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckOutButton extends StatelessWidget {
  final List<CartModel> cartItems;

  const CheckOutButton({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    OpenDetailsProvider openDetailsProvider = context
        .watch<OpenDetailsProvider>();
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final cartPriceProvider = context.read<CartPriceProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 14.h,
              bottom: 5.h,
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border.all(color: theme.primaryColor, width: 1.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    openDetailsProvider.toggle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        data: "Order Summery",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      openDetailsProvider.isOpen
                          ? Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: theme.primaryColor,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: theme.primaryColor,
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Consumer<CartPriceProvider>(
                  builder: (context, cartPriceProvider, child) {
                    return Column(
                      children: [
                        AnimatedSize(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,

                          child: openDetailsProvider.isOpen
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
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
                                      child: Divider(
                                        color: appColors.dividerColor,
                                        thickness: 1.h,
                                        height: 1.h,
                                      ),
                                    ),
                                    PriceRow(
                                      title: "Discount",
                                      suffix: CustomText(
                                        data: '\$${cartPriceProvider.discount}',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 15.h,
                                      child: Divider(
                                        color: appColors.dividerColor,
                                        thickness: 1.h,
                                        height: 1.h,
                                      ),
                                    ),

                                    // Shipping
                                    PriceRow(
                                      title: loc.shipping,
                                      suffix: CustomText(
                                        data:
                                            '\$${cartPriceProvider.currentShipping}',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                      child: Divider(
                                        color: appColors.dividerColor,
                                        thickness: 1.h,
                                        height: 1.h,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        // Total
                        PriceRow(
                          title: loc!.total,
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: CustomText(
                                  data:
                                      '(${cartPriceProvider.count} ${loc.items} )',
                                  fontSize: 13.sp,
                                  color: appColors.containerBorder,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              if (cartPriceProvider.discount != 0) ...[
                                Flexible(
                                  child: CustomText(
                                    data: '\$${cartPriceProvider.total}',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                              ],
                              Flexible(
                                child: CustomText(
                                  lined: cartPriceProvider.discount != 0,
                                  data: '\$${cartPriceProvider.totalNoDis}',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: cartPriceProvider.discount != 0
                                      ? theme.dividerColor
                                      : null,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
          CustomElevatedButton(
            outlinedBorder: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.checkoutScreen, extra: {
                'cartItems': cartItems,
                'cartPriceProvider': cartPriceProvider,
              });
            },
            buttonChild: CustomText(
              data: loc!.processtocheckout,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
