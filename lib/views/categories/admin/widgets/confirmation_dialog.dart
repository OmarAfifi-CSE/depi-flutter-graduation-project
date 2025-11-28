import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
    this.confirmText,
    this.confirmButtonColor,
  });

  final VoidCallback onConfirm;
  final String title;
  final String content;
  final String? confirmText;
  final Color? confirmButtonColor;

  static void show(
    BuildContext context, {
    required VoidCallback onConfirm,
    required String title,
    required String content,
    String? confirmText,
    Color? confirmButtonColor,
  }) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        onConfirm: onConfirm,
        title: title,
        content: content,
        confirmText: confirmText,
        confirmButtonColor: confirmButtonColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: CustomText(
        data: title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      content: CustomText(
        data: content,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        CustomElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          buttonChild: CustomText(
            data: loc!.cancel,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: theme.scaffoldBackgroundColor,
            forceStrutHeight: true,
          ),
        ),
        SizedBox(height: 8.h),
        CustomElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          backgroundColor: confirmButtonColor ?? Colors.green,
          buttonChild: CustomText(
            data: confirmText ?? loc.save,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: theme.scaffoldBackgroundColor,
            forceStrutHeight: true,
          ),
        ),
      ],
    );
  }
}
