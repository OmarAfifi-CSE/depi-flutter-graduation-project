import 'package:batrina/views/profile/widgets/profile_menu_item.dart';
import 'package:batrina/views/profile/widgets/profile_settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/styling/app_colors.dart';

import 'widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Scaffold(
      backgroundColor: appColors.textFieldFill,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    ProfileHeader(
                      name: 'Wello',
                      email: 'wello6668@gmail.com',
                      onBack: () {},
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: appColors.card!, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: appColors.containerBorder!.withValues(
                              alpha: 0.2,
                            ),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          ProfileMenuItem(
                            icon: Icons.person,
                            title: loc.personalDetails,
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.shopping_bag,
                            title: loc.myOrder,
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.favorite,
                            title: loc.myFavourites,
                            onTap: () {},
                          ),
                          ProfileMenuItem(
                            icon: Icons.local_shipping,
                            title: loc.shippingAddress,
                            onTap: () {},
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
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                        // top: 4.h,
                      ),
                      child: Align(
                        alignment:
                            Localizations.localeOf(context).languageCode == 'ar'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          loc.settings,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: appColors.card!, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: appColors.containerBorder!.withValues(
                              alpha: 0.2,
                            ),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          ProfileSettingsItem(
                            icon: Icons.language,
                            title: loc.language,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? 'العربية'
                                      : 'English',
                                  style: TextStyle(
                                    color: appColors.secondaryText,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.chevron_right,
                                  color: appColors.secondaryText,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),

                          ProfileSettingsItem(
                            icon: Icons.notifications,
                            title: loc.notifications,
                            trailing: Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: notificationEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    notificationEnabled = value;
                                  });
                                },
                                activeThumbColor: theme.primaryColor,
                                inactiveThumbColor: appColors.secondaryText,
                                inactiveTrackColor: appColors.card,
                              ),
                            ),
                          ),
                          ProfileSettingsItem(
                            icon: Icons.dark_mode,
                            title: loc.darkMode,
                            trailing: Consumer<ThemeProvider>(
                              builder: (context, themeProvider, child) {
                                final isDark =
                                    themeProvider.themeMode == ThemeMode.dark;
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      isDark
                                          ? AppLocalizations.of(context)!.on
                                          : AppLocalizations.of(context)!.off,
                                      style: TextStyle(
                                        color: appColors.secondaryText,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Switch(
                                        value: isDark,
                                        onChanged: (value) {
                                          themeProvider.setTheme(
                                            value
                                                ? ThemeMode.dark
                                                : ThemeMode.light,
                                          );
                                        },
                                        activeThumbColor: theme.primaryColor,
                                        inactiveThumbColor:
                                            appColors.secondaryText,
                                        inactiveTrackColor: appColors.card,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
