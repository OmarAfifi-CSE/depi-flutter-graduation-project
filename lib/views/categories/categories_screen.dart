import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:batrina/views/categories/widgets/category_list_view.dart';
import 'package:batrina/views/categories/widgets/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => CategoryCubit()..fetchCategories(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return SearchBarWidget(
                              onChanged: (query) {
                                context.read<CategoryCubit>().searchCategories(
                                  query,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withValues(
                                  alpha: .15,
                                ),
                                blurRadius: 10,
                                offset: Offset(0, 2.h),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Material(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(50.r),
                            child: InkWell(
                              onTap: () {
                                // TODO: Go to filter screen
                              },
                              borderRadius: BorderRadius.circular(50.r),
                              splashColor: theme.scaffoldBackgroundColor
                                  .withValues(alpha: 0.2),
                              child: Container(
                                width: 50.w,
                                height: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.filterIcon,
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(
                                    theme.scaffoldBackgroundColor,
                                    BlendMode.srcIn,
                                  ),
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
              SizedBox(height: 22.h),
              const CategoryListView(),
            ],
          ),
        ),
      ),
    );
  }
}
