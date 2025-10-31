import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/cart/checkout/widgets/product_card.dart';
import 'package:batrina/views/cart/widget/price_row.dart';
import 'package:batrina/views/profile/shipping_address/widgets/address_card.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartModel> cartItems;
  final CartPriceProvider cartPriceProvider;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.cartPriceProvider,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    final AddressModel addressModel = AddressModel(
      id: '10',
      street: "123 Main St",
      city: "Anytown",
      phoneNumber: "123-456-7890",
      country: "Country",
    );
    return Scaffold(
      appBar: AppBar(
        title: CustomHeaderWidget(
          center: CustomText(
            data: loc!.checkout,
            textAlign: TextAlign.center,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
          prefix: const BackArrow(),
        ),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data: loc.deliveryAddress,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(
                      height: 180.h,
                      child: AddressCard(addressModel: addressModel),
                    ),
                    SizedBox(height: 24.h),
                    CustomText(
                      data: loc.products,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 12.h,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(cartModel: cartItems[index]);
                  },
                ),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              data: loc.total,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              data:
                                  '(${cartPriceProvider.count} ${loc.items} )',
                              fontSize: 13.sp,
                              color: appColors.containerBorder,
                              fontWeight: FontWeight.w500,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (cartPriceProvider.discount != 0) ...[
                              Flexible(
                                child: CustomText(
                                  data: '\$${cartPriceProvider.total}',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  maxLines: 1,
                                  fontFamily: AppFonts.englishFontFamily,
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
                                fontFamily: AppFonts.englishFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                      child: CustomElevatedButton(
                        onPressed: () {},
                        extend: true,
                        outlinedBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        buttonChild: CustomText(
                          data: loc.placeOrder,
                          fontSize: 16.sp,
                          color: theme.scaffoldBackgroundColor,
                          fontWeight: FontWeight.w600,
                          forceStrutHeight: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
