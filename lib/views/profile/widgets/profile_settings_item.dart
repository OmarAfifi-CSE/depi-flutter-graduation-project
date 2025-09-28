import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/styling/app_colors.dart';

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

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: appColors.textFieldFill,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 34.sp, color: appColors.containerBorder),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: theme.primaryColor,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
