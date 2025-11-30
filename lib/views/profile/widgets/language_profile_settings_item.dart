import 'package:batrina/controllers/provider/locale_provider.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/utils/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class LanguageProfileSettingsItem extends StatelessWidget {
  const LanguageProfileSettingsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final currentCode = localeProvider.locale.languageCode;
    final currentLanguageName = LanguageHelper.getNativeName(currentCode);

    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.languageSelectionScreen);
      },
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: appColors.dividerColor?.withValues(alpha: .7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.language, size: 22.sp, color: theme.primaryColor),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                data: currentLanguageName,
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
      ),
    );
  }
}
