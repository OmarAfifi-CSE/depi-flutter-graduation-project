import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'widgets/category_list_view.dart';
import 'widgets/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              const SearchBarWidget(),
              SizedBox(height: 22.h),
              const CategoryListView(),
            ],
          ),
        ),
      ),
    );
  }
}
