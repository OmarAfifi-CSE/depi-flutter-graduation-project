import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../../styling/app_colors.dart';
import '../../styling/app_fonts.dart';
import '../../widgets/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? emailValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email !';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Please enter a valid email address !';
    }
    return null;
  }

  String? nameValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required !';
    }
    if (value.length < 2) {
      return 'Name is too short !';
    }
    return null;
  }

  String? passValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password !';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters long !';
    }
    if (!RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$',
    ).hasMatch(value.trim())) {
      return 'Password must contain upper, lower case letters and a number !';
    }
    return null;
  }

  void validation() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 70.h),
                        //temp
                        Icon(
                              Icons.check_circle,
                              size: 100.sp,
                              color: theme.primaryColor,
                            )
                            .animate()
                            .fade(duration: Duration(milliseconds: 500))
                            .shimmer(duration: 1000.ms)
                            .moveY(
                              begin: -300,
                              end: 0,
                              duration: 1000.ms,
                              curve: Curves.easeInOut,
                            ),
                        SizedBox(height: 107.h),
                        Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomText(
                                  data: loc!.signUpTitle,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 6.h),
                                CustomText(
                                  data: loc.signUpDescription,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.secondaryText,
                                ),
                              ],
                            )
                            .animate(delay: 200.ms)
                            .fadeIn()
                            .moveX(
                              begin: -600,
                              end: 0,
                              duration: 1000.ms,
                              curve: Curves.easeInOut,
                            ),
                        SizedBox(height: 60.h),

                        Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                    controller: userNameController,
                                    labelText: loc.userNameTitle,
                                    validator: nameValidation,
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
                                    controller: emailController,
                                    labelText: loc.emailTitle,
                                    validator: emailValidation,
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
                                    controller: passwordController,
                                    labelText: loc.passwordTitle,
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
                                    labelText: loc.confirmPasswordTitle,
                                    obscureText: true,
                                    validator: passValidation,
                                  )
                                  .animate(delay: 400.ms)
                                  .fadeIn(duration: 1000.ms)
                                  .moveX(
                                    begin: -300,
                                    end: 0,
                                    duration: 1000.ms,
                                    curve: Curves.easeInOut,
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                CustomElevatedButton(
                      backgroundColor: theme.primaryColor,
                      onPressed: validation,
                      buttonChild: Text(
                        loc.signUpTitle,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: AppFonts.mainFontName,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                    )
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 500.ms)
                    .scale(
                      duration: 1000.ms,
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      curve: Curves.elasticOut,
                    )
                    .shimmer(duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
