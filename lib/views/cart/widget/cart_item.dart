import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/cart/widget/cart_counter.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:batrina/widgets/build_dynamic_image.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> with TickerProviderStateMixin {
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

  Future<void> deleteFromCart() async {
    try {
      setState(() {
        isDeleting = true;
      });
      await FireBaseFireStore().removeFromCart(cartId: widget.cartModel.id);

      // ابدأ انيمشن الخروج
      await exitAnimationController.forward();
      await sizeAnimationController.forward();

      if (mounted) {
        context.read<GetCartCubit>().removeLocal(widget.cartModel.id);
        context.read<CartPriceProvider>().refresh();
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
          message: "error happened",
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

  Future<void> deleteFromQuantity() async {
    if (!isOpen) {
      openSlider();
      await Future.delayed(const Duration(milliseconds: 200));
      deleteFromCart();
    } else {
      deleteFromCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizeTransition(
        sizeFactor: sizeAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideOutAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 15.w),
              child: SizedBox(
                height: 100.h,
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
                          onTap: isDeleting ? null : deleteFromCart,
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
                                      AppRoutes.categoryProductScreen,
                                      pathParameters: {
                                        'categoryName':
                                            widget.cartModel.categoryName,
                                        'productId': widget.cartModel.productId,
                                      },
                                      queryParameters: {
                                        'size': widget.cartModel.size,
                                        'color': widget.cartModel.color,
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
                                    width: 80.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(12.r),
                                      clipBehavior: Clip.antiAlias,
                                      child: BuildDynamicImage(
                                        imageUrl: widget.cartModel.thumbnail,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          data: widget.cartModel.productName,
                                          textAlign: TextAlign.start,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          maxLines: 1,
                                          fontFamily:
                                              AppFonts.englishFontFamily,
                                        ),
                                        CustomText(
                                          data: widget.cartModel.subtitle,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: appColors.secondaryText,
                                          maxLines: 1,
                                          fontFamily:
                                              AppFonts.englishFontFamily,
                                        ),
                                        const Spacer(),
                                        CustomText(
                                          data: "\$${widget.cartModel.price}",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily:
                                              AppFonts.englishFontFamily,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      _buildSizeOption(),
                                      SizedBox(height: 4.h),
                                      _buildColorOption(),
                                      const Spacer(),
                                      AbsorbPointer(
                                        absorbing: isDeleting,
                                        child: CartCounter(
                                          cartModel: widget.cartModel,
                                          deleteFromQuantity:
                                              deleteFromQuantity,
                                        ),
                                      ),
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
    );
  }

  Widget _buildSizeOption() {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      width: widget.cartModel.size != "OneSize" ? 20.w : 70.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: widget.cartModel.size != "OneSize"
            ? BoxShape.circle
            : BoxShape.rectangle,
        color: theme.primaryColor,
        border: Border.all(color: appColors.containerBorder!),
      ),
      child: Center(
        child: CustomText(
          data: widget.cartModel.size != "OneSize"
              ? widget.cartModel.size
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
    final productColor = widget.cartModel.colorWidget;
    // Check its luminance (0.0 = black, 1.0 = white)
    final bool isLightColor =
        productColor.computeLuminance() > 0.5;

    final Color checkmarkColor = isLightColor
        ? lightCheckmark
        : darkCheckmark;
    final Color borderColor = isLightColor
        ? lightBorder
        : darkBorder;
    final Color shadowColor = isLightColor
        ? lightShadow
        : darkShadow;
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: productColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: checkmarkColor,
          size: 14.sp,
        ),
      ),
    );
  }
}
