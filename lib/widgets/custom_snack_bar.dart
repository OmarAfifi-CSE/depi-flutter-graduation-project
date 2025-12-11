import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static Future<dynamic> showSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
    Duration duration = const Duration(milliseconds: 1200),
    bool longText = false,
  }) {
    if (!context.mounted) return Future.value();
    final theme = Theme.of(context);
    final Widget snackBarContent = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: FittedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1.sw - 32.w, maxHeight: 0.1.sh),
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
              !longText
                  ? Expanded(
                      child: FittedBox(
                        alignment: AlignmentDirectional.centerStart,
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          data: message,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          forceStrutHeight: true,
                        ),
                      ),
                    )
                  : Expanded(
                      child: CustomText(
                        data: message,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        forceStrutHeight: true,
                        textAlign: TextAlign.start,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );

    return Flushbar(
      messageText: snackBarContent,
      isDismissible: false,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,

      margin: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
      borderRadius: BorderRadius.circular(8.r),

      // --- Animation & Duration ---
      duration: duration,
      animationDuration: 1000.ms,
      forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
    ).show(context);
  }
}
