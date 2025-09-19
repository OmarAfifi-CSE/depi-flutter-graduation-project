import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/onboarding/widgets/angled_image_container.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOnboardingPage extends StatelessWidget {
  const CustomOnboardingPage({
    super.key,
    required String image,
    required String title,
    required String subTitle,
  }) : _image = image,
       _title = title,
       _subTitle = subTitle;
  final String _image;
  final String _title;
  final String _subTitle;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child:
          Column(
            children: [
              AngledImageContainer(
                imageUrl: _image,
                height: 444.h,
                width: MediaQuery.widthOf(context),
                borderColor: Colors.transparent,
                borderWidth: 0.0,
                fit: BoxFit.cover,
                angleHeight: 33.h,
                borderRadius: 20.r,
              ),
              SizedBox(height: 68.h),
              CustomText(
                data: _title,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 18.h),
              CustomText(
                data: _subTitle,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: appColors.secondaryText,
              ),
            ],
          ).animate().fadeIn(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          ),
    );
  }
}
