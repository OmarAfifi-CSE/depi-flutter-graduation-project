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
import 'package:batrina/l10n/app_localizations.dart';
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
  late AnimationController slideAnimationController;
  late AnimationController sizeAnimationController;
  late AnimationController exitAnimationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> exitAnimation;
  late Animation<double> sizeAnimation;

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
    exitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: exitAnimationController, curve: Curves.easeInOut),
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

  void _handleSwipe(DragUpdateDetails details) {
    if (isDeleting) return;

    final isRTL = Directionality.of(context) == TextDirection.rtl;

    if (isRTL) {
      // RTL: سحب يمين = فتح، سحب شمال = قفل
      if (details.delta.dx > 2 && !isOpen) {
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
      } else if (details.delta.dx < -2 && isOpen) {
        slideAnimationController.reverse();
        setState(() {
          isOpen = false;
          boxShadow = BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
          );
        });
      }
    } else {
      // LTR: سحب شمال = فتح، سحب يمين = قفل
      if (details.delta.dx < -2 && !isOpen) {
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
      } else if (details.delta.dx > 2 && isOpen) {
        slideAnimationController.reverse();
        setState(() {
          isOpen = false;
          boxShadow = BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return SizeTransition(
      sizeFactor: sizeAnimation,
      child: FadeTransition(
        opacity: exitAnimation,
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: Offset.zero,
                end: Offset(
                  isRTL ? -1.5 : 1.5,
                  0,
                ), // RTL: يطلع شمال، LTR: يطلع يمين
              ).animate(
                CurvedAnimation(
                  parent: exitAnimationController,
                  curve: Curves.easeInOut,
                ),
              ),
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
                      padding: EdgeInsets.only(
                        right: isRTL ? 0 : 16.w,
                        left: isRTL ? 16.w : 0,
                      ),
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: isDeleting ? null : deleteFromCart,
                        child: isDeleting
                            ? CupertinoActivityIndicator(
                                color: theme.scaffoldBackgroundColor,
                              )
                            : SvgPicture.asset(
                                AppAssets.deleteIcon,
                                color: theme.scaffoldBackgroundColor,
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
                          isRTL
                              ? -slideAnimation.value.dx
                              : slideAnimation.value.dx,
                          slideAnimation.value.dy,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.productScreen,
                              pathParameters: {
                                'categoryName': widget.cartModel.categoryName,
                                'productId': widget.cartModel.productId,
                              },
                              queryParameters: {
                                'size': widget.cartModel.size,
                                'color': widget.cartModel.color,
                              },
                            );
                          },
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
                                        fontFamily: AppFonts.englishFontFamily,
                                      ),
                                      CustomText(
                                        data: widget.cartModel.subtitle,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: appColors.secondaryText,
                                        maxLines: 1,
                                        fontFamily: AppFonts.englishFontFamily,
                                      ),
                                      const Spacer(),
                                      CustomText(
                                        data: "\$${widget.cartModel.price}",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppFonts.englishFontFamily,
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
                                    CartCounter(cartModel: widget.cartModel),
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
    );
  }

  Widget _buildSizeOption() {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primaryColor,
        border: Border.all(color: appColors.containerBorder!),
      ),
      child: Center(
        child: CustomText(
          data: widget.cartModel.size,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: theme.scaffoldBackgroundColor,
          fontFamily: AppFonts.englishFontFamily,
        ),
      ),
    );
  }

  Widget _buildColorOption() {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.cartModel.color == "#FFFFFF"
              ? appColors.containerBorder!
              : Colors.transparent,
        ),
        color: widget.cartModel.colorWidget,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: widget.cartModel.color != "#FFFFFF"
              ? theme.scaffoldBackgroundColor
              : appColors.containerBorder,
          size: 13.sp,
        ),
      ),
    );
  }
}
