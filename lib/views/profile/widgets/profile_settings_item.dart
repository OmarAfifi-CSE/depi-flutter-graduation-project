import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/styling/app_colors.dart';

import 'package:batrina/widgets/custom_text.dart';

class ProfileSettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const ProfileSettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: appColors.dividerColor?.withValues(alpha: .7),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 22.sp, color: theme.primaryColor),
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
        trailing,
      ],
    );
  }
}
