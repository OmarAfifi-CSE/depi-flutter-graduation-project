import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:batrina/controllers/cubit/product/cart_cubit/cart_cubit.dart';
import 'package:batrina/controllers/cubit/profile/get_wish_list_cubit/get_wish_list_cubit.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/wish_list_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WishListRow extends StatefulWidget {
  const WishListRow({super.key, required this.wishlistModel});

  final WishlistModel wishlistModel;

  @override
  State<WishListRow> createState() => _WishListRowState();
}

class _WishListRowState extends State<WishListRow>
    with TickerProviderStateMixin {
  late AnimationController sizeAnimationController;

  late Animation<double> sizeAnimation;

  late AnimationController exitAnimationController;

  late Animation<Offset> slideAnimation;

  late Animation<double> fadeAnimation;

  late AnimationController slideAnimationController;

  late Animation<Offset> slideOutAnimation;

  BoxShadow? boxShadow;

  bool isOpen = false;

  bool isDeleting = false;

  Future<void> deleteFromWishList(AppLocalizations? loc) async {
    try {
      setState(() {
        isDeleting = true;
      });
      await FireBaseFireStore().removeFromWishList(
        wishListModel: widget.wishlistModel,
      );

      // ابدأ انيمشن الخروج
      await exitAnimationController.forward();
      await sizeAnimationController.forward();

      if (mounted) {
        context.read<GetWishListCubit>().removeLocal(widget.wishlistModel.id);
      }
    } catch (e) {
      if (mounted) {
        if (isOpen) {
          slideAnimationController.reverse();
          setState(() {
            isOpen = false;
            boxShadow = BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
            );
          });
        }
        setState(() {
          isDeleting = false;
        });
        exitAnimationController.reverse();
        CustomSnackBar.showSnackBar(
          context: context,
          message: loc!.errorHappened,
          color: Colors.red,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    sizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    exitAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    slideAnimation = Tween(begin: Offset.zero, end: Offset(-50.w, 0)).animate(
      CurvedAnimation(
        parent: slideAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    sizeAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: sizeAnimationController, curve: Curves.easeInOut),
    );
    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: exitAnimationController, curve: Curves.easeInOut),
    );
    slideOutAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(1, 0),
        ).animate(
          CurvedAnimation(
            parent: exitAnimationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    boxShadow ??= BoxShadow(color: Theme.of(context).scaffoldBackgroundColor);
  }

  @override
  void dispose() {
    slideAnimationController.dispose();
    sizeAnimationController.dispose();
    exitAnimationController.dispose();
    super.dispose();
  }

  void openSlider() {
    slideAnimationController.forward();
    setState(() {
      isOpen = true;
      boxShadow = BoxShadow(
        color: Theme.of(context).primaryColor.withValues(alpha: .15),
        blurRadius: 10,
        spreadRadius: 3,
        offset: const Offset(0, 0),
      );
    });
  }

  void closeSlider() {
    slideAnimationController.reverse();
    setState(() {
      isOpen = false;
      boxShadow = BoxShadow(color: Theme.of(context).scaffoldBackgroundColor);
    });
  }

  void _handleSwipe(DragUpdateDetails details) {
    if (isDeleting) return;
    if (details.delta.dx < -2 && !isOpen) {
      openSlider();
    } else if (details.delta.dx > 2 && isOpen) {
      closeSlider();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => CartCubit()..context = context,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SizeTransition(
          sizeFactor: sizeAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideOutAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0.h,
                  horizontal: 15.w,
                ),
                child: SizedBox(
                  height: 140.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: theme.primaryColor,
                          ),
                          padding: EdgeInsets.only(right: 16.w),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: isDeleting
                                ? null
                                : () {
                                    deleteFromWishList(loc);
                                  },
                            child: isDeleting
                                ? CupertinoActivityIndicator(
                                    color: theme.scaffoldBackgroundColor,
                                  )
                                : SvgPicture.asset(
                                    AppAssets.deleteIcon,
                                    colorFilter: ColorFilter.mode(
                                      theme.scaffoldBackgroundColor,
                                      BlendMode.srcIn,
                                    ),
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.scaleDown,
                                  ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: slideAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              slideAnimation.value.dx,
                              slideAnimation.value.dy,
                            ),
                            child: GestureDetector(
                              onTap: !isDeleting
                                  ? () {
                                      context.pushNamed(
                                        AppRoutes.productScreen,
                                        pathParameters: {
                                          'productId':
                                              widget.wishlistModel.productId,
                                        },
                                        queryParameters: {
                                          'size': widget.wishlistModel.size,
                                          'color': widget.wishlistModel.color,
                                        },
                                      );
                                    }
                                  : null,
                              onHorizontalDragUpdate: _handleSwipe,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: theme.scaffoldBackgroundColor,
                                  boxShadow: boxShadow != null
                                      ? [boxShadow!]
                                      : null,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: BuildDynamicImage(
                                          imageUrl:
                                              widget.wishlistModel.thumbnail,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4.h),
                                          CustomText(
                                            data: widget
                                                .wishlistModel
                                                .productName,
                                            textAlign: TextAlign.start,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            maxLines: 2,
                                            fontFamily:
                                                AppFonts.englishFontFamily,
                                          ),
                                          CustomText(
                                            data: widget.wishlistModel.subtitle,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: appColors.secondaryText,
                                            maxLines: 1,
                                            fontFamily:
                                                AppFonts.englishFontFamily,
                                          ),
                                          const Spacer(),
                                          CustomText(
                                            data:
                                                "\$${widget.wishlistModel.price}",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily:
                                                AppFonts.englishFontFamily,
                                          ),
                                          SizedBox(height: 4.h),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(height: 4.h),
                                        GestureDetector(
                                          onTap: isDeleting
                                              ? null
                                              : () {
                                                  deleteFromWishList(loc);
                                                },
                                          child: Container(
                                            width: 28.w,
                                            height: 28.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: theme.primaryColor,
                                              border: Border.all(
                                                color:
                                                    appColors.containerBorder!,
                                              ),
                                            ),
                                            child: Center(
                                              child: isDeleting
                                                  ? CupertinoActivityIndicator(
                                                      radius: 8.w,
                                                      color: theme
                                                          .scaffoldBackgroundColor,
                                                    )
                                                  : SvgPicture.asset(
                                                      AppAssets.heartIconFilled,
                                                      width: 16.w,
                                                      height: 16.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        _buildSizeOption(),
                                        SizedBox(height: 4.h),
                                        _buildColorOption(),
                                        const Spacer(),
                                        BlocBuilder<GetCartCubit, GetCartState>(
                                          builder: (context, getCartState) {
                                            if (getCartState
                                                is GetCartInitial) {
                                              context
                                                  .read<GetCartCubit>()
                                                  .getCart();
                                            }
                                            if (getCartState
                                                is! GetCartSuccess) {
                                              return CupertinoActivityIndicator(
                                                color: theme.primaryColor,
                                              );
                                            }

                                            CartModel? cartItem;
                                            try {
                                              cartItem = getCartState.userCart
                                                  .firstWhere(
                                                    (item) =>
                                                        item.productId ==
                                                            widget
                                                                .wishlistModel
                                                                .productId &&
                                                        item.variantId ==
                                                            widget
                                                                .wishlistModel
                                                                .variantId,
                                                  );
                                            } catch (e) {
                                              cartItem = null; // مش موجود
                                            }

                                            final bool isInCart =
                                                cartItem != null;

                                            return BlocConsumer<
                                              CartCubit,
                                              CartState
                                            >(
                                              listener: (context, cartState) {
                                                if (cartState
                                                    is AddToCartSuccess) {
                                                  CustomSnackBar.showSnackBar(
                                                    context: context,
                                                    message:
                                                        loc!.productAddedToCart,

                                                    color: Colors.green,
                                                  );
                                                } else if (cartState
                                                    is RemoveFromCartSuccess) {
                                                  CustomSnackBar.showSnackBar(
                                                    context: context,
                                                    message: loc!
                                                        .productRemovedFromCart,
                                                    color: Colors.red,
                                                  );
                                                } else if (cartState
                                                    is CartFailure) {
                                                  CustomSnackBar.showSnackBar(
                                                    context: context,
                                                    message: cartState.error,
                                                    color: Colors.red,
                                                  );
                                                }
                                              },
                                              builder: (context, cartState) {
                                                if (cartState is CartLoading) {
                                                  return SizedBox(
                                                    height: 20.h,
                                                    width: 20.w,
                                                    child:
                                                        CupertinoActivityIndicator(
                                                          color: theme
                                                              .primaryColor,
                                                        ),
                                                  );
                                                }

                                                return GestureDetector(
                                                  onTap: () {
                                                    if (isInCart) {
                                                      context
                                                          .read<CartCubit>()
                                                          .removeFromCart(
                                                            cartId:
                                                                cartItem!.id,
                                                          );
                                                    } else {
                                                      final newCartItem =
                                                          CartModel(
                                                            id: '',
                                                            productId: widget
                                                                .wishlistModel
                                                                .productId,
                                                            variantId: widget
                                                                .wishlistModel
                                                                .variantId,
                                                            productName: widget
                                                                .wishlistModel
                                                                .productName,
                                                            subtitle: widget
                                                                .wishlistModel
                                                                .subtitle,
                                                            categoryName: widget
                                                                .wishlistModel
                                                                .categoryName,
                                                            color: widget
                                                                .wishlistModel
                                                                .color,
                                                            size: widget
                                                                .wishlistModel
                                                                .size,
                                                            price: widget
                                                                .wishlistModel
                                                                .price,
                                                            thumbnail: widget
                                                                .wishlistModel
                                                                .thumbnail,
                                                            availableStock: widget
                                                                .wishlistModel
                                                                .availableStock,
                                                            quantity: 1,
                                                            addedAt:
                                                                DateTime.now(),
                                                          );

                                                      context
                                                          .read<CartCubit>()
                                                          .addToCart(
                                                            cartModel:
                                                                newCartItem,
                                                          );
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    isInCart
                                                        ? AppAssets
                                                              .removeCartIcon
                                                        : AppAssets.cartIcon,
                                                    colorFilter: ColorFilter.mode(
                                                      isInCart
                                                          ? Colors.red
                                                          : theme.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                    width: 24.w,
                                                    height: 24.h,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(height: 4.h),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeOption() {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      width: widget.wishlistModel.size != "Standard" ? 20.w : 70.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: widget.wishlistModel.size != "Standard"
            ? BoxShape.circle
            : BoxShape.rectangle,
        color: theme.primaryColor,
        border: Border.all(color: appColors.containerBorder!),
      ),
      child: Center(
        child: CustomText(
          data: widget.wishlistModel.size != "Standard"
              ? widget.wishlistModel.size
              : "Standard",
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: theme.scaffoldBackgroundColor,
          fontFamily: AppFonts.englishFontFamily,
        ),
      ),
    );
  }

  Widget _buildColorOption() {
    // Colors for LIGHT product variants
    const Color lightCheckmark = Colors.black87;
    final Color lightBorder = Colors.black.withValues(alpha: 0.2);
    final Color lightShadow = Colors.black.withValues(alpha: 0.15);

    // Colors for DARK product variants
    const Color darkCheckmark = Colors.white;
    final Color darkBorder = Colors.white.withValues(alpha: 0.3);
    final Color darkShadow = Colors.black.withValues(alpha: 0.2);
    final productColor = widget.wishlistModel.colorWidget;
    // Check its luminance (0.0 = black, 1.0 = white)
    final bool isLightColor = productColor.computeLuminance() > 0.5;

    final Color checkmarkColor = isLightColor ? lightCheckmark : darkCheckmark;
    final Color borderColor = isLightColor ? lightBorder : darkBorder;
    final Color shadowColor = isLightColor ? lightShadow : darkShadow;
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: productColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 2, spreadRadius: 1),
        ],
      ),
      child: Center(
        child: Icon(Icons.check, color: checkmarkColor, size: 14.sp),
      ),
    );
  }
}
