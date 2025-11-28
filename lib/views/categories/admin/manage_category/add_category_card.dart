import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddCategoryCard extends StatelessWidget {
  const AddCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: GestureDetector(
        onTap: () {
          final categoryCubit = context.read<CategoryCubit>();
          context.pushNamed(AppRoutes.manageCategoryScreen, extra: categoryCubit);
        },
        child: Container(
          height: 160.h,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: .15),
                blurRadius: 5,
                offset: Offset(0, 5.h),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.scaffoldBackgroundColor.withValues(alpha: 0.15),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 32.sp,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
              SizedBox(height: 12.h),
              CustomText(
                data: loc!.addCategory,
                color: theme.scaffoldBackgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              SizedBox(height: 4.h),
              CustomText(
                data: loc.tapToAdd,
                color: theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
