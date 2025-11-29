import 'dart:ui';
import 'package:batrina/controllers/cubit/admin/admin_mode/admin_mode_cubit.dart';
import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/models/category_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryModel category;
  final EdgeInsetsGeometry? padding;

  const CategoryCardWidget({super.key, required this.category, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAdminMode = context.watch<AdminModeCubit>().state;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.categoryProductsScreen,
          pathParameters: {'categoryName': category.name},
        );
      },
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 25.w),
        child: Container(
          decoration: BoxDecoration(
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
          child: SizedBox(
            height: 160.h,
            child: Stack(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(20.r),
                  clipBehavior: Clip.antiAlias,
                  child: BuildDynamicImage(imageUrl: category.image),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 180.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10.w,
                                sigmaY: 10.h,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.englishFontFamily,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isAdminMode)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () {
                        final categoryCubit = context.read<CategoryCubit>();
                        context.pushNamed(
                          AppRoutes.manageCategoryScreen,
                          extra: {'cubit': categoryCubit, 'category': category},
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: theme.scaffoldBackgroundColor,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
