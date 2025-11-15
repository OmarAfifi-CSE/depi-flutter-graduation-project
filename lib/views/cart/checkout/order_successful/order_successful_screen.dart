import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopScope(
      // Prevent the user from going "back" to the checkout screen
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  AppAssets.successAnimation,
                  width: 250.w,
                  height: 250.h,
                  repeat: false, // Only play once
                ),
                SizedBox(height: 32.h),

                // The Title
                CustomText(
                  data: loc!.orderPlacedSuccessfully,
                  textAlign: TextAlign.center,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 16.h),

                // The Subtitle
                CustomText(
                  data: loc.orderSuccessSubtitle,
                  textAlign: TextAlign.center,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: theme.hintColor,
                ),
                SizedBox(height: 48.h),

                // Primary Button (Back to Home)
                CustomElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.wrapperScreen);
                  },
                  buttonChild: CustomText(
                    data: loc.backToHome,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.scaffoldBackgroundColor,
                    forceStrutHeight: true,
                  ),
                ),
                SizedBox(height: 8.h),

                // Secondary Button (View Orders)
                TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent
                  ),
                  onPressed: () {
                    context.goNamed(AppRoutes.ordersScreen);
                  },
                  child: CustomText(
                    data: loc.trackYourOrder,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
