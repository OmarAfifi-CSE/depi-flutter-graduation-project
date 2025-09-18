import 'package:batrina/views/onboarding/widgets/angled_image_container.dart';
import 'package:flutter/cupertino.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child:
          Column(
            children: [
              AngledImageContainer(
                imageUrl: _image,
                // width: double.infinity,
                height: 444.h,
                borderColor: Colors.transparent,
                borderWidth: 0.0,
                fit: BoxFit.cover,
                angleHeight: 33.h,
                borderRadius: 20.r,
              ),
              SizedBox(height: 68.h),
              Text(_title, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 18.h),
              Text(_subTitle, style: Theme.of(context).textTheme.titleSmall),
            ],
          ).animate().fadeIn(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          ),
    );
  }
}
