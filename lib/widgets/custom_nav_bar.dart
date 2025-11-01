import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_nav_bar_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BottomAppBar(
      key: ValueKey(theme.scaffoldBackgroundColor.toString()),
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(top: 10.h, left: 30.w, right: 30.w),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.r),
            topLeft: Radius.circular(40.r),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: .15),
              blurRadius: 10,
              spreadRadius: -3,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomNavBarIcon(
              path: AppAssets.homeIcon,
              name: loc!.home,
              isSelected: navigationShell.currentIndex == 0,
              onTap: () => _selectTab(context, 0),
            ),
            CustomNavBarIcon(
              path: AppAssets.categoriesIcon,
              name: loc.categories,
              isSelected: navigationShell.currentIndex == 1,
              onTap: () => _selectTab(context, 1),
            ),
            CustomNavBarIcon(
              path: AppAssets.cartIcon,
              name: loc.cart,
              isSelected: navigationShell.currentIndex == 2,
              onTap: () => _selectTab(context, 2),
            ),
            CustomNavBarIcon(
              path: AppAssets.profileIcon,
              name: loc.profile,
              isSelected: navigationShell.currentIndex == 3,
              onTap: () => _selectTab(context, 3),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTab(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
