import 'package:batrina/controllers/cubit/product/get_user_cart_for_product_cubit/get_user_cart_for_product_cubit.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:batrina/controllers/cubit/product/cart_cubit/cart_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productModel});

  final ProductModel productModel;

  void addToCart({
    required ProductProvider productProvider,
    required BuildContext context,
  }) {
    context.read<CartCubit>().addToCart(
      cartModel: CartModel(
        id: "id",
        categoryName: productProvider.productModel.categoryName,
        subtitle: productProvider.productModel.subtitle,
        productId: productProvider.productModel.id,
        productName: productProvider.productModel.name,
        quantity: productProvider.currentQuantity,
        variantId: productProvider.variant?.id ?? "",
        color: productProvider.currentColorName ?? "",
        size: productProvider.currentSize ?? "",
        price: productProvider.productModel.finalPrice,
        thumbnail: productProvider.currentSliderImage.first,
        availableStock: productProvider.variant?.stock ?? 1,
        addedAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetUserCartForProductCubit()
                ..getUserCartForProduct(productModel: productModel),
        ),
        BlocProvider(create: (context) => CartCubit()..context = context),
      ],
      child: BlocBuilder<GetUserCartForProductCubit, GetUserCartForProductState>(
        builder: (context, state) {
          return Consumer<ProductProvider>(
            builder: (BuildContext context, ProductProvider productProvider, Widget? child) {
              CartModel? cartItem;
              if (state is GetUserCartForProductSuccess) {
                try {
                  cartItem = state.userCartForProduct.firstWhere(
                    (element) =>
                        element.variantId == productProvider.variant?.id,
                  );
                } catch (e) {
                  cartItem = null;
                }
              }
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
                    state is GetUserCartForProductSuccess
                        ? BlocConsumer<CartCubit, CartState>(
                                listener: (context, state) {
                                  if (state is AddToCartSuccess) {
                                    CustomSnackBar.showSnackBar(
                                      context: context,
                                      message: loc!.productAddedToCart,
                                      color: Colors.green,
                                    );
                                  } else if (state is RemoveFromCartSuccess) {
                                    CustomSnackBar.showSnackBar(
                                      context: context,
                                      message: loc!.productRemovedFromCart,
                                      color: Colors.red,
                                    );
                                  } else if (state is CartFailure) {
                                    CustomSnackBar.showSnackBar(
                                      context: context,
                                      message: state.error,
                                      color: Colors.red,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return state is! CartLoading
                                      ? SizedBox(
                                          height: 40.h,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              backgroundColor:
                                                  theme.scaffoldBackgroundColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      12.r,
                                                    ),
                                              ),
                                            ),
                                            onPressed:
                                                productProvider
                                                        .currentVariantStock !=
                                                    0
                                                ? () {
                                                    if (cartItem != null) {
                                                      context
                                                          .read<CartCubit>()
                                                          .removeFromCart(
                                                            cartId: cartItem.id,
                                                          );
                                                    } else {
                                                      addToCart(
                                                        productProvider:
                                                            productProvider,
                                                        context: context,
                                                      );
                                                    }
                                                  }
                                                : () {},
                                            child:
                                                productProvider
                                                        .currentVariantStock !=
                                                    0
                                                ? Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      cartItem == null
                                                          ? SvgPicture.asset(
                                                              AppAssets
                                                                  .cartIcon,
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                    theme
                                                                        .primaryColor,
                                                                    BlendMode
                                                                        .srcIn,
                                                                  ),
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .remove_shopping_cart,
                                                              color: Colors.red,
                                                            ),
                                                      SizedBox(width: 4.w),
                                                      CustomText(
                                                        data: cartItem == null
                                                            ? loc!.addToCart
                                                            : loc!.removeFromCart,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  )
                                                : Center(
                                                    child: CustomText(
                                                      data: loc!.notAvailable,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                          ),
                                        )
                                      : CupertinoActivityIndicator(
                                          color: theme.scaffoldBackgroundColor,
                                        );
                                },
                              )
                              .animate()
                              .fadeIn(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 400),
                              )
                              .slideY(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 400),
                                begin: 10,
                                end: 0,
                              )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
