import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../../styling/app_colors.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/custom_header_widget.dart';
import '../../widgets/custom_text.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.oobCode});

  final String oobCode;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? passValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.passwordEmptyDescription;
    }
    if (value.trim().length < 6) {
      return loc!.passwordTooShortDescription;
    }
    if (!RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$',
    ).hasMatch(value.trim())) {
      return loc!.passwordWeakDescription;
    }
    return null;
  }

  String? confirmPassValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (passwordController.text.trim() != value) {
      return loc!.passwordMustMatch;
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
                  data: "Create New Password",
                  fontWeight: FontWeight.w500,
                  fontSize: 23.sp,
                ),
              ),
              CustomTextFormField(
                    controller: passwordController,
                    labelText: loc!.passwordTitle,
                    validator: passValidation,
                    obscureText: true,
                  )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 1000.ms)
                  .moveX(
                    begin: -300,
                    end: 0,
                    duration: 1000.ms,
                    curve: Curves.easeInOut,
                  ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                    controller: confirmPasswordController,
                    labelText: loc!.confirmPasswordTitle,
                    obscureText: true,
                    validator: confirmPassValidation,
                  )
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 1000.ms)
                  .moveX(
                    begin: -300,
                    end: 0,
                    duration: 1000.ms,
                    curve: Curves.easeInOut,
                  ),
              CustomElevatedButton(
                    onPressed: () {},
                    buttonChild: CustomText(
                      data: "Confirm",
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
