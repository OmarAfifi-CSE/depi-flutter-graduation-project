import 'package:batrina/controllers/cubit/admin/admin_mode/admin_mode_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/widgets/custom_text.dart';

class AdminControlCard extends StatelessWidget {
  const AdminControlCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return BlocBuilder<AdminModeCubit, bool>(
      builder: (context, isAdminMode) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: 30.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: isAdminMode
                ? Colors.orange.shade50.withValues(alpha: 0.1)
                : theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isAdminMode ? Colors.orange : appColors.dividerColor!,
              width: isAdminMode ? 1.5 : 1,
            ),
            boxShadow: isAdminMode
                ? [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: isAdminMode
                      ? Colors.orange
                      : theme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isAdminMode
                      ? Icons.admin_panel_settings
                      : Icons.person_outline,
                  color: theme.primaryColor,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data: loc!.adminDashboard,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: isAdminMode ? Colors.orange : null,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      data: isAdminMode
                          ? loc.activeEditingMode
                          : loc.viewAsCustomer,
                      fontSize: 12.sp,
                      color: isAdminMode
                          ? Colors.orange.withValues(alpha: 0.8)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Switch(
                value: isAdminMode,
                activeThumbColor: Colors.orange,
                activeTrackColor: Colors.orange.withValues(alpha: 0.3),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
                onChanged: (val) {
                  context.read<AdminModeCubit>().toggleMode();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
