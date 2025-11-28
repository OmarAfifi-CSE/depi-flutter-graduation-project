import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryFilter extends StatelessWidget {
  final ValueNotifier<String> selectedCategoryNotifier;

  const CategoryFilter({super.key, required this.selectedCategoryNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return SizedBox(
            height: 40.h,
            child: Center(
              child: CupertinoActivityIndicator(color: theme.primaryColor),
            ),
          );
        } else if (state is CategoryError) {
          return SizedBox(
            height: 40.h,
            child: Center(child: Text(state.message)),
          );
        } else if (state is CategorySuccess) {
          final categories = state.categories;
          if (categories.isEmpty) {
            return SizedBox(
              height: 40.h,
              child: const Center(child: Text('No categories found.')),
            );
          }
          // If nothing selected, or selected category doesn't exist anymore (deleted), select first.
          final bool isSelectedValid = categories.any(
            (c) => c.name == selectedCategoryNotifier.value,
          );

          if (selectedCategoryNotifier.value.isEmpty || !isSelectedValid) {
            if (categories.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final first = categories.first.name;
                if (selectedCategoryNotifier.value != first) {
                  selectedCategoryNotifier.value = first;
                  context.read<ProductsProvider>().refresh(first);
                }
              });
            }
          }

          return SizedBox(
            height: 40.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: categories.length,
              separatorBuilder: (context, index) => SizedBox(width: 15.w),
              itemBuilder: (context, index) {
                final category = categories[index];
                return ValueListenableBuilder<String>(
                  valueListenable: selectedCategoryNotifier,
                  builder: (context, selectedCategoryValue, child) {
                    final isSelected = category.name == selectedCategoryValue;
                    return GestureDetector(
                      onTap: () {
                        context.read<ProductsProvider>().refresh(category.name);
                        selectedCategoryNotifier.value = category.name;
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.primaryColor
                              : theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 8,
                                    offset: Offset(0, 5.h),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: CustomText(
                            data: category.name,
                            fontSize: 14.sp,
                            color: isSelected
                                ? theme.scaffoldBackgroundColor
                                : theme.primaryColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontFamily: AppFonts.englishFontFamily,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
        return SizedBox(height: 40.h);
      },
    );
  }
}
