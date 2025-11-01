import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyCategoryWidget extends StatelessWidget {
  final String categoryName;

  const EmptyCategoryWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            theme.brightness == Brightness.light
                ? AppAssets.noDataFoundAnimation
                : AppAssets.noDataFoundAnimationWhite,
            width: 150.w,
            height: 150.h,
            fit: BoxFit.scaleDown,
          ),
          CustomText(
            data: loc.nothingFound,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Directionality(
            textDirection: loc.localeName == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: CustomText(
              data: loc.emptyCategoryDescription(categoryName),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: theme.primaryColor.withValues(alpha: 0.7),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
