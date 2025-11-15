import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/profile/widgets/language_profile_settings_item.dart';
import 'package:batrina/views/profile/widgets/profile_info.dart';
import 'package:batrina/views/profile/widgets/profile_settings_item.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
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
    context.read<ProfileProvider>().initialize(
      name: FireBaseFireStore.currentUser?.name ?? 'User',
      image: FireBaseFireStore.currentUser?.picture,
    );

    super.initState();
  }

  Future<void> _handleLogout() async {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final bool? didConfirm = await showDialog<bool>(
      context: context,
      builder: (alertDialogContext) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: CustomText(
          data: loc.logOut,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        content: CustomText(
          data: loc.areYouSureToLogout,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          CustomElevatedButton(
            onPressed: () => Navigator.of(alertDialogContext).pop(false),
            buttonChild: CustomText(
              data: loc.cancel,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: theme.scaffoldBackgroundColor,
              forceStrutHeight: true,
            ),
          ),
          CustomElevatedButton(
            onPressed: () => Navigator.of(alertDialogContext).pop(true),
            backgroundColor: Colors.red,
            buttonChild: CustomText(
              data: loc.logOut,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: theme.scaffoldBackgroundColor,
              forceStrutHeight: true,
            ),
          ),
        ],
      ),
    );

    if (didConfirm == true && mounted) {
      try {
        await FirebaseAuth.instance.signOut();
        context.read<ProfileProvider>().clearData();
        if (mounted) {
          context.go(AppRoutes.signInScreen);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                data: loc.failedToLogout(e),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
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
              border: Border.all(color: appColors.dividerColor!, width: 2.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                spacing: 10.h,
                children: [
                  SizedBox(height: 30.h),
                  const LanguageProfileSettingsItem(),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) {
                      final isDark = themeProvider.themeMode == ThemeMode.dark;
                      return ProfileSettingsItem(
                        icon: Icons.dark_mode,
                        title: loc.darkMode,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: isDark,
                                onChanged: (value) {
                                  themeProvider.setTheme(
                                    value ? ThemeMode.dark : ThemeMode.light,
                                  );
                                },
                                activeThumbColor: theme.primaryColor,
                                inactiveThumbColor: appColors.secondaryText,
                                inactiveTrackColor: appColors.dividerColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: _handleLogout,
                    child: ProfileSettingsItem(
                      icon: Icons.logout,
                      title: loc.logOut,
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
