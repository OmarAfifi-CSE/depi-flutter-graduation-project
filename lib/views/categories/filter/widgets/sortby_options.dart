import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SortByOptions extends StatelessWidget {
  const SortByOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filter = Provider.of<FilterProvider>(context);
    return Row(
      children: filter.options.map((option) {
        final isSelected = filter.selectedSort == option;
        return Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                filter.setSort(null);
              } else {
                filter.setSort(option);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : theme.cardColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: theme.primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? theme.cardColor : theme.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
