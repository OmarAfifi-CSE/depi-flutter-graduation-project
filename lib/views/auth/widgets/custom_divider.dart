import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(color: const Color(0xffE8ECF4), thickness: 1.h),
        ),
        SizedBox(width: 12.w),
        CustomText(
          data: AppLocalizations.of(context)!.orTitle,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Divider(color: const Color(0xffE8ECF4), thickness: 1.h),
        ),
      ],
    );
  }
}
