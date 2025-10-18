import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/categories/widgets/category_card_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoryLoading() || CategoryInitial():
            return Center(
              child: CupertinoActivityIndicator(color: theme.primaryColor),
            );
          case CategoryError():
            return Center(
              child: CustomText(
                data: loc!.defaultError,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          case CategorySuccess():
            if (state.categories.isEmpty) {
              return Center(
                child: CustomText(
                  data: loc!.emptyCategories,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                itemCount: state.categories.length,
                itemBuilder: (context, i) {
                  return CategoryCardWidget(category: state.categories[i]);
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                padding: EdgeInsets.only(bottom: 20.h),
              ),
            );
        }
      },
    );
  }
}
