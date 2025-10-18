import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';

class LanguageProfileSettingsItem extends StatefulWidget {
  const LanguageProfileSettingsItem({super.key});

  @override
  State<LanguageProfileSettingsItem> createState() =>
      _LanguageProfileSettingsItemState();
}

class _LanguageProfileSettingsItemState
    extends State<LanguageProfileSettingsItem>
    with SingleTickerProviderStateMixin {
  double height = 40.h;
  bool viewChooses = false;

  Duration openDuration = const Duration(milliseconds: 300);
  Duration changeDuration = const Duration(milliseconds: 300);
  bool isClickable = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider = context.watch<LocaleProvider>();
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return GestureDetector(
      onTap: () async {
        if (isClickable) {
          isClickable = false;
          if (height == 40.h) {
            setState(() {
              height = 100.h;
            });
            await Future.delayed(openDuration);
            setState(() {
              viewChooses = true;
            });
          } else {}
          isClickable = true;
        }
      },

      child: AnimatedContainer(
        duration: openDuration,
        curve: Curves.easeInOut,
        height: height,
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(-0.3, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              ),
            );
          },
          child: viewChooses == false
              ? Row(
                  key: const ValueKey('languageDisplay'),

                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: appColors.card?.withValues(alpha: .7),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.language,
                        size: 22.sp,
                        color: theme.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsGeometry.directional(start: 12.0.w),
                        child: CustomText(
                          textAlign: TextAlign.start,
                          data: loc.language,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    Row(
                      key: const ValueKey('languageChoices'),

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          data: isArabic ? 'العربية' : 'English',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: appColors.secondaryText,
                          forceStrutHeight: true,
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.chevron_right,
                          color: appColors.secondaryText,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (isClickable) {
                          isClickable = false;
                          localeProvider.setLocale("en");
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );
                          setState(() {
                            viewChooses = false;
                          });
                          await Future.delayed(changeDuration);
                          setState(() {
                            height = 40.h;
                          });
                          await Future.delayed(openDuration);
                          isClickable = true;
                        }
                      },
                      child: Container(
                        width: 120.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: !isArabic
                              ? theme.primaryColor
                              : theme.scaffoldBackgroundColor,
                          border: isArabic
                              ? Border.all(
                                  width: 2,
                                  color: appColors.card!.withValues(alpha: .7),
                                )
                              : null,
                          borderRadius: BorderRadiusGeometry.circular(12.r),
                        ),
                        child: Center(
                          child: CustomText(
                            data: "English",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.englishFontFamily,
                            color: !isArabic
                                ? theme.scaffoldBackgroundColor
                                : null,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (isClickable) {
                          isClickable = false;

                          localeProvider.setLocale("ar");
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );

                          setState(() {
                            viewChooses = false;
                          });
                          await Future.delayed(changeDuration);

                          setState(() {
                            height = 40.h;
                          });
                          await Future.delayed(openDuration);
                          isClickable = true;
                        }
                      },
                      child: Container(
                        width: 120.w,
                        height: 60.h,

                        decoration: BoxDecoration(
                          color: isArabic
                              ? theme.primaryColor
                              : theme.scaffoldBackgroundColor,
                          border: !isArabic
                              ? Border.all(
                                  width: 2,
                                  color: appColors.card!.withValues(alpha: .7),
                                )
                              : null,
                          borderRadius: BorderRadiusGeometry.circular(12.r),
                        ),
                        child: Center(
                          child: CustomText(
                            data: "العربيه",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.arabicFontFamily,
                            color: isArabic
                                ? theme.scaffoldBackgroundColor
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
