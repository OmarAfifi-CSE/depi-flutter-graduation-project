import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/views/profile/widgets/language_profile_settings_item.dart';
import 'package:batrina/views/profile/widgets/profile_info.dart';
import 'package:batrina/views/profile/widgets/profile_settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:batrina/controllers/provider/theme_provider.dart';
import 'package:batrina/styling/app_colors.dart';

import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/views/profile/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationEnabled = true;

  @override
  void initState() {
    context.read<ProfileProvider>().initilize(
      name: FireBaseFireStore.currentUser!.name,
      image: FireBaseFireStore.currentUser!.picture,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    const ProfileHeader(),
                    SizedBox(height: 30.h),
                    const ProfileInfo(),
                    SizedBox(height: 30.h),

                    CustomText(
                      data: loc.settings,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),

                    SizedBox(height: 5.h),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: appColors.card!, width: 2.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          spacing: 10.h,
                          children: [
                            SizedBox(height: 30.h),
                            const LanguageProfileSettingsItem(),
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
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, _) {
                                final isDark =
                                    themeProvider.themeMode == ThemeMode.dark;
                                return ProfileSettingsItem(
                                  icon:
                                      themeProvider.themeMode == ThemeMode.dark
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  title:
                                      themeProvider.themeMode == ThemeMode.dark
                                      ? loc.darkMode
                                      : loc.lightMode,
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
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
