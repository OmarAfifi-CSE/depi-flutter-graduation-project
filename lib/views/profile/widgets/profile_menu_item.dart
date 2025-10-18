import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:batrina/widgets/custom_text.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String? svg;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.svg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadiusGeometry.circular(8.r),
      child: InkWell(
        customBorder: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8.r),
        ),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: appColors.card?.withValues(alpha: .7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: icon != null
                  ? Center(
                      child: Icon(icon, color: theme.primaryColor, size: 22.w),
                    )
                  : SvgPicture.asset(
                      width: 22.w,
                      height: 22.w,
                      svg!,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.directional(start: 12.0.w),
                child: CustomText(
                  textAlign: TextAlign.start,
                  data: title,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: theme.primaryColor, size: 22.sp),
          ],
        ),
      ),
    );
  }
}
