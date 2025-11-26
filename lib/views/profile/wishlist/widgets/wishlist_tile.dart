import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WishlistCard extends StatefulWidget {
  const WishlistCard({super.key, required this.product});
  final ProductModel product;

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard>
    with TickerProviderStateMixin {
  late AnimationController sizeAnimationController;
  late Animation<double> sizeAnimation;
  late AnimationController exitAnimationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideOutAnimation;

  bool isDeleting = false;

  Future<void> deleteFromWishlist() async {
    try {
      setState(() {
        isDeleting = true;
      });
      await FireBaseFireStore().removeFromWishList(
        productModel: widget.product,
      );

      // Start exit animation
      await exitAnimationController.forward();
      await sizeAnimationController.forward();

      if (mounted) {
        // Optional: Refresh wishlist if you have a provider/cubit
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isDeleting = false;
        });
        exitAnimationController.reverse();
        sizeAnimationController.reverse();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error removing from wishlist"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    sizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    exitAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
  void dispose() {
    sizeAnimationController.dispose();
    exitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizeTransition(
      sizeFactor: sizeAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideOutAnimation,
          child: Card(
            margin: EdgeInsets.only(bottom: 12.h),
            color: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: GestureDetector(
              onTap: isDeleting
                  ? null
                  : () {
                      GoRouter.of(context).pushNamed(
                        AppRoutes.productScreen,
                        pathParameters: {'productId': widget.product.id},
                      );
                    },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        width: 80.w,
                        height: 80.h,
                        child: Image.network(
                          widget.product.thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data: widget.product.name,
                            textAlign: TextAlign.start,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            fontFamily: AppFonts.englishFontFamily,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            data: widget.product.subtitle,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            maxLines: 1,
                            fontFamily: AppFonts.englishFontFamily,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            data: "\$${widget.product.price}",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.englishFontFamily,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    AbsorbPointer(
                      absorbing: isDeleting,
                      child: GestureDetector(
                        onTap: deleteFromWishlist,
                        child: isDeleting
                            ? CupertinoActivityIndicator(
                                color: theme.primaryColor,
                              )
                            : SvgPicture.asset(
                                'assets/icons/delete-wishlist-com.svg',
                                width: 30.w,
                                height: 30.h,
                                fit: BoxFit.cover,
                              ),
                      ),
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
}
