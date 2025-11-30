import 'package:batrina/utils/language_helper.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.locale,
    required this.isSelected,
    required this.onTap,
  });

  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final nativeName = LanguageHelper.getNativeName(locale.languageCode);
    final englishName = LanguageHelper.getEnglishName(locale.languageCode);
    final flag = LanguageHelper.getFlag(locale.languageCode);
    final fontName = LanguageHelper.getFontFamily(locale.languageCode);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor
              : theme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: .3),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Text(flag, style: TextStyle(fontSize: 22.sp)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: nativeName,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: fontName,
                    color: isSelected
                        ? theme.scaffoldBackgroundColor
                        : theme.primaryColor,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    data: englishName,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: isSelected
                        ? theme.scaffoldBackgroundColor.withValues(alpha: 0.5)
                        : theme.primaryColor.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
            _buildSelectionIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? theme.scaffoldBackgroundColor : null,
        border: Border.all(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: 16.sp, color: theme.primaryColor)
          : null,
    );
  }
}
