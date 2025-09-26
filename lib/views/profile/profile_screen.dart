import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Scaffold(
      backgroundColor: appColors.textFieldFill,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: 14.r,
            top: 7.r,
            bottom: 7.r,
          ),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.scaffoldBackgroundColor,
              size: 20.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: appColors.containerBorder!.withValues(alpha: 0.5),
                    spreadRadius: .5,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/Favhoto-01-30_22-26-47.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wello',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'wello6668@gmail.com',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: appColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 33.h),
            Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: appColors.card!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: appColors.containerBorder!.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.person,
                    title: 'Personal Details',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.shopping_bag,
                    title: 'My Order',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.favorite,
                    title: 'My Favourites',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.local_shipping,
                    title: 'Shipping Address',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.credit_card,
                    title: 'My Card',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.settings,
                    title: loc.settings,
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 4.w, top: 4.h, bottom: 4.h),
              child: Align(
                alignment: Localizations.localeOf(context).languageCode == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  loc.settings,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: appColors.card!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: appColors.containerBorder!.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.language,
                    title: loc.language,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'English',
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
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.notifications,
                    title: 'Notifications',
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
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: darkModeEnabled,
                        onChanged: (value) {
                          setState(() {
                            darkModeEnabled = value;
                          });
                        },
                        activeThumbColor: theme.primaryColor,
                        inactiveThumbColor: appColors.secondaryText,
                        inactiveTrackColor: appColors.card,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: appColors.textFieldFill,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 30.sp, color: appColors.containerBorder),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: theme.primaryColor,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: appColors.secondaryText,
        size: 25.sp,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: appColors.textFieldFill,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 30.sp, color: appColors.containerBorder),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: theme.primaryColor,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
