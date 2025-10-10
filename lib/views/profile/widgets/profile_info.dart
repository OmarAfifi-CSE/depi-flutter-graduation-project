import 'package:animations/animations.dart';
import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/views/profile/personal_details.dart';
import 'package:batrina/views/profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../styling/app_colors.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: appColors.card!, width: 2.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          spacing: 10.h,

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 30),
            ProfileMenuItem(
              icon: Icons.person,
              title: loc.personalDetails,
              onTap: () {
                context.pushNamed(AppRoutes.personalDetails);
              },
            ),
            ProfileMenuItem(
              icon: Icons.shopping_bag,
              title: loc.myOrders,
              onTap: () {},
            ),
            ProfileMenuItem(
              svg: theme.brightness != Brightness.light
                  ? AppAssets.heartIconFilledWhite
                  : AppAssets.heartIconFilledBlack,
              title: loc.myFavourites,
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.local_shipping,
              title: loc.shippingAddress,
              onTap: () {
                context.pushNamed(AppRoutes.addressesScreen);
              },
            ),
            ProfileMenuItem(
              icon: Icons.credit_card,
              title: loc.myCard,
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.settings,
              title: loc.settings,
              onTap: () {},
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
