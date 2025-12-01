import 'package:batrina/controllers/cubit/auth/auth_cubit/auth_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text_form_field.dart';
import 'package:batrina/views/auth/widgets/sign_up_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
    final loc = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) {
      return loc!.emailEmptyDescription;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return loc!.emailInvalidDescription;
    }
    return null;
  }

  String? nameValidation(String? value) {
    final loc = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return loc!.nameEmptyDescription;
    }
    if (value.length < 2) {
      return loc!.nameTooShortDescription;
    }
    return null;
  }

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

  void validation() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      await context.read<AuthCubit>().signUp(
        email: emailController.text.trim(),
        pass: passwordController.text.trim(),
        name: userNameController.text.trim(),
      );
    }
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
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 50.h),
                        Lottie.asset(
                          AppAssets.secureLoginAnimation,
                          width: 200.r,
                          height: 200.r,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(height: 30.h),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 44.h),
                SignUpButton(validation: validation),
                SizedBox(height: 10.h),
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          data: loc.alreadyAUserTitle,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: CustomText(
                            data: loc.signInTitle,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                    .animate(delay: 450.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(
                      delay: 200.ms,
                      begin: 0.5,
                      end: 0,
                      duration: 500.ms,
                    ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
