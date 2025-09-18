import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
  }) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: MediaQuery.heightOf(context) - 150.h),
        content: FittedBox(
          child: Row(
            children: [
              Icon(
                color == Colors.green
                    ? Icons.check_circle
                    : color == Colors.red
                    ? Icons.remove_circle
                    : Icons.info,
                color: theme.scaffoldBackgroundColor,
              ),
              const SizedBox(width: 8),
              CustomText(
                data: message,
                fontSize: 40.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
