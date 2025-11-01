import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            AppAssets.emptyCartAnimation,
            width: 150.w,
            height: 150.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 24.h),
          CustomText(
            data: loc.emptyCartTitle,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          CustomText(
            data:loc.emptyCartSubtitle,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
            color: theme.primaryColor.withValues(alpha: 0.7),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.wrapperScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 20.sp,
                    color: theme.scaffoldBackgroundColor,
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    data: loc.continueShopping,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.scaffoldBackgroundColor,
                    forceStrutHeight: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
