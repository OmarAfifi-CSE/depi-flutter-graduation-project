import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SortbyOptions extends StatelessWidget {
  const SortbyOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final filter = Provider.of<FilterProvider>(context);
    return Row(
      children: filter.options.map((option) {
        final isSelected = filter.selectedSort == option;
        return Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () {
              filter.setSort(option);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : theme.cardColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color:theme.primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? theme.cardColor :theme.primaryColor,
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
