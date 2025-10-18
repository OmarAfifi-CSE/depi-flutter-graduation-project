import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/styling/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = context.watch<ProfileProvider>();
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      height: 80.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: .2),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          profileProvider.mainImage != null
              ? Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(12.r),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(12.r),
                    clipBehavior: Clip.antiAlias, // This is the key property
                    child: BuildDynamicImage(
                      imageUrl: profileProvider.mainImage!,
                    ),
                  ),
                )
              : Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(12.r),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data: profileProvider.mainName,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.englishFontFamily,
                  maxLines: 1,
                ),
                SizedBox(height: 1.h),
                // The email address is constant because it represents the current authenticated user and does not change during the session.
                CustomText(
                  data: FireBaseFireStore.currentUser!.email,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: appColors.secondaryText,
                  fontFamily: AppFonts.englishFontFamily,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
