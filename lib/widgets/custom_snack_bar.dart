import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        margin: EdgeInsets.only(bottom: MediaQuery.heightOf(context) - 120.h),
        content:
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: FittedBox(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1.sw - 32.w,
                    maxHeight: 0.1.sh,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        color == Colors.green
                            ? Icons.check_circle
                            : color == Colors.red
                            ? Icons.remove_circle
                            : Icons.info,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        child: CustomText(
                          data: message,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().slideY(
              begin: 3,
              end: 0,
              duration: 1000.ms,
              curve: Curves.elasticOut,
            ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
