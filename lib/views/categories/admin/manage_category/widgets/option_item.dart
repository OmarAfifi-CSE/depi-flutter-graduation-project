import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            child: Icon(icon, size: 30.sp, color: theme.primaryColor),
          ),
          SizedBox(height: 8.h),
          CustomText(data: label, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
