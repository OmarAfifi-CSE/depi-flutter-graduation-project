import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/views/profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';

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
        border: Border.all(color: appColors.dividerColor!, width: 2.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.w),
        child: Column(
          spacing: 10.h,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileMenuItem(
              icon: Icons.person,
              title: loc.personalDetails,
              onTap: () {
                context.pushNamed(AppRoutes.personalDetailsScreen);
              },
            ),
            ProfileMenuItem(
              icon: Icons.chat_bubble,
              title: loc.messages,
              onTap: () {
                context.push(AppRoutes.chatsScreen);
              },
            ),
            ProfileMenuItem(
              icon: Icons.shopping_bag,
              title: loc.myOrders,
              onTap: () {
                context.pushNamed(AppRoutes.ordersScreen);
              },
            ),
            ProfileMenuItem(
              svg: theme.brightness != Brightness.light
                  ? AppAssets.heartIconFilledWhite
                  : AppAssets.heartIconFilledBlack,
              title: loc.wishlist,
              onTap: () {
                context.pushNamed(AppRoutes.wishlistScreen);
              },
            ),
            ProfileMenuItem(
              icon: Icons.local_shipping,
              title: loc.shippingAddress,
              onTap: () {
                context.pushNamed(AppRoutes.addressesScreen);
              },
            ),
            // ProfileMenuItem(
            //   icon: Icons.credit_card,
            //   title: loc.myCard,
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
