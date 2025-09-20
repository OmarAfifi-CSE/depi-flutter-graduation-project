import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../l10n/app_localizations.dart';
import '../../styling/app_colors.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController emailCont = TextEditingController();

  String? emailValidation(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) {
      return loc!.emailEmptyDescription;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return loc!.emailInvalidDescription;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 9.h),
              CustomHeaderWidget(
                prefix: const BackArrow(),
                center: CustomText(
                  data: loc!.resetPassword,
                  fontWeight: FontWeight.w500,
                  fontSize: 23.sp,
                ),
              ),
              Center(
                child: Lottie.asset(
                  AppAssets.forgotPassword,
                  height: 400.h,
                  width: 400.w,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 0.h),
              CustomText(
                data: loc.resetPasswordLabel,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: appColors.secondaryText,
              ),
              SizedBox(height: 10.h),
              Hero(
                tag: "email",
                child: Material(
                  color: Colors.transparent,
                  child: CustomTextFormField(
                    controller: emailCont,
                    labelText: loc.emailTitle,
                    validator: emailValidation,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              CustomElevatedButton(
                    onPressed: () {},
                    buttonChild: CustomText(
                      data: loc.sendInstruction,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  )
                  .animate()
                  .fadeIn(
                    delay: const Duration(milliseconds: 500),

                    duration: const Duration(milliseconds: 500),
                  )
                  .shimmer(color: theme.scaffoldBackgroundColor)
                  .slideY(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    begin: 4,
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
