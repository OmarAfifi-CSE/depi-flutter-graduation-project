import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:provider/provider.dart';


class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterProvider>(context);
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Wrap(
      spacing: 12.w,
      runSpacing: 10.h,
      children: filter.categories.map((category) {
        final isSelected = filter.selectedCategories.contains(category);
        return GestureDetector(
          onTap: () {
            filter.toggleCategory(category);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? theme.primaryColor: theme.cardColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color:theme.primaryColor.withAlpha(80),
                width: 1,
              ),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? theme.cardColor : theme.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
