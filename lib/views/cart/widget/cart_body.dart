import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/cart/widget/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/cart/widget/check_out_details.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../../controllers/provider/cart_price_provider.dart';
import '../../../styling/app_colors.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (context) => CartPriceProvider(),
      child: BlocBuilder<GetCartCubit, GetCartState>(
        builder: (context, state) {
          if (state is GetCartFailure) {
            return Center(
              child: CustomText(
                data: state.error,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          } else if (state is GetCartLoading) {
            return Center(
              child: CupertinoActivityIndicator(color: theme.primaryColor),
            );
          }
          final List<CartModel> userCart = (state as GetCartSuccess).userCart;
          context.read<CartPriceProvider>().init(cart: userCart, shipping: 50);

          return userCart.isNotEmpty
              ? Column(
                  children: [
                    // My Cart title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                      child: _buildCartTitle(context),
                    ),

                    //هنضيف بادينج علي كل واحد لوحدو علشان الانيمشن يظبط
                    SizedBox(height: 4.h),
                    // Cart items
                    SizedBox(
                      height: 350.h,
                      child: _buildCartItems(context, userCart),
                    ),

                    SizedBox(height: 30.h),

                    // Order summary
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                      child: const CheckOutDetails(),
                    ),
                    // Checkout button
                    const Spacer(),
                    CustomElevatedButton(
                      onPressed: () {},
                      buttonChild: CustomText(
                        data: loc!.processtocheckout,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CustomText(
                    data: "Empty",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
          ;
        },
      ),
    );
  }

  Widget _buildCartTitle(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: CustomText(
        data: loc!.mycart,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, List<CartModel> cart) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsetsGeometry.only(top: 9.h),
      separatorBuilder: (context, index) {
        return SizedBox(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Divider(
                color: appColors.card,
                thickness: 1.h,
                height: 1.h,
              ),
            ),
          ),
        );
      },
      itemCount: cart.length,
      itemBuilder: (context, index) {
        return CardItem(key: ValueKey(cart[index].id), cartModel: cart[index]);
      },
    );
  }
}
