import 'package:batrina/models/category_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryModel category;
  final EdgeInsetsGeometry? padding;

  const CategoryCardWidget({super.key, required this.category, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor.withValues(
                                alpha: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.englishFontFamily,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
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
