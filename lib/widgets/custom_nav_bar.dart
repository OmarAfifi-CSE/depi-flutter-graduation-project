import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/cubit/nav_control/nav_control_cubit.dart';
import 'custom_nav_bar_icon.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocBuilder<NavControlCubit, NavControlState>(
      builder: (context, state) {
        return BottomAppBar(
          //to solve if there additional space
          key: ValueKey(theme.scaffoldBackgroundColor.toString()),
          color: theme.scaffoldBackgroundColor,
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.only(top: 10.h, left: 40.w, right: 40.w),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.r),
                topLeft: Radius.circular(40.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(.2),
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(0, -15),
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
                  isSelected: state.index == 0,
                  onTap: () => _selectTab(context, 0),
                ),
                CustomNavBarIcon(
                  path: AppAssets.cartIcon,
                  name: loc.cart,
                  isSelected: state.index == 1,
                  onTap: () => _selectTab(context, 1),
                ),
                CustomNavBarIcon(
                  path: AppAssets.notIcon,
                  name: loc.notification,
                  isSelected: state.index == 2,
                  onTap: () => _selectTab(context, 2),
                ),
                CustomNavBarIcon(
                  path: AppAssets.profileIcon,
                  name: loc.profile,
                  isSelected: state.index == 3,
                  onTap: () => _selectTab(context, 3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectTab(BuildContext context, int index) {
    context.read<NavControlCubit>().setIndex(index);
  }
}
