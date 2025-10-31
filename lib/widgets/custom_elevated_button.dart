import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonChild,
    this.backgroundColor,
    this.outlinedBorder,
    this.extend = false,
  });

  final VoidCallback? onPressed;
  final Widget buttonChild;
  final Color? backgroundColor;
  final OutlinedBorder? outlinedBorder;
  final bool extend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.primaryColor,
        foregroundColor: theme.scaffoldBackgroundColor,
        fixedSize: extend == false ? Size(325.w, 46.h) : null,
        shape:
            outlinedBorder ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        disabledBackgroundColor: theme.disabledColor,
      ),
      child: extend
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [buttonChild],
            )
          : buttonChild,
    );
  }
}
