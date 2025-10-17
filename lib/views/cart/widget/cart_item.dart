import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/cart/widget/cart_counter.dart';
import 'package:batrina/views/product/widgets/counter.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/cart/widget/quant_counter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/build_dynamic_image.dart';

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

  // كده كده هنعمل ريبلد هنا مش فارقه معايا
  Future<void> deleteFromCart() async {
    try {
      setState(() {
        isDeleting = true;
      });
      await FireBaseFireStore().removeFromCart(cartId: widget.cartModel.id);

      // ابدأ انيمشن الخروج
      await exitAnimationController.forward();

      await sizeAnimationController.forward();
      context.read<GetCartCubit>().removeLocal(widget.cartModel.id);
      context.read<CartPriceProvider>().refresh();
    } catch (e) {
      setState(() {
        isDeleting = false;
      });
      CustomSnackBar.showSnackBar(
        context: context,
        message: "error happened",
        color: Colors.green,
      );
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
    slideAnimation = Tween(begin: Offset.zero, end: const Offset(-50, 0))
        .animate(
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
        boxShadow = BoxShadow(color: Theme.of(context).scaffoldBackgroundColor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);

    return SizeTransition(
      sizeFactor: sizeAnimation,
      child: FadeTransition(
        opacity: exitAnimation,
        child: SlideTransition(
          position: Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, 0))
              .animate(
                CurvedAnimation(
                  parent: exitAnimationController,
                  curve: Curves.easeInOut,
                ),
              ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
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
                      padding: EdgeInsetsGeometry.only(right: 16.w),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: isDeleting
                            ? () {}
                            : () {
                                deleteFromCart();
                              },
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
                        offset: slideAnimation.value,
                        child: GestureDetector(
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
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 6.0.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText(
                                              data:
                                                  widget.cartModel.productName,
                                              textAlign: TextAlign.start,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                              maxLines: 1,
                                              fontFamily:
                                                  AppFonts.englishFontFamily,
                                            ),
                                            SizedBox(height: 6.h),
                                            CustomText(
                                              data: widget.cartModel.subtitle,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: appColors.secondaryText,
                                              maxLines: 1,
                                              fontFamily:
                                                  AppFonts.englishFontFamily,
                                            ),
                                          ],
                                        ),
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
                                ),
                                SizedBox(width: 4.w),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _buildSizeOption(),
                                        SizedBox(height: 1.h),
                                        _buildColorOption(),
                                      ],
                                    ),
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
