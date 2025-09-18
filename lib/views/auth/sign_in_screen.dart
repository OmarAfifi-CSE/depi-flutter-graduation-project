import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/auth/widgets/custom_divider.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70.h),
                  //temp
                  Icon(
                        Icons.check_circle,
                        size: 140.sp,
                        color: theme.primaryColor,
                      )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 500))
                      .shimmer(duration: 1000.ms)
                      .moveY(
                        begin: -300,
                        end: 0,
                        duration: 1000.ms,
                        curve: Curves.easeInOut,
                      ),
                  SizedBox(height: 70.h),
                  Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            data: loc!.welcomeTitle,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 6.h),
                          CustomText(
                            data: loc.welcomeDescription,
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
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                  SizedBox(height: 44.h),
                  CustomElevatedButton(
                        onPressed: () {},
                        buttonChild: Text(
                          loc.loginTitle,
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
                  SizedBox(height: 6.h),
                  const CustomDivider()
                      .animate(delay: 1350.ms)
                      .fadeIn(duration: 550.ms)
                      .scale(
                        duration: 1000.ms,
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        curve: Curves.elasticOut,
                      )
                      .shimmer(duration: 500.ms),
                  SizedBox(height: 6.h),
                  CustomElevatedButton(
                        onPressed: validation,
                        backgroundColor: const Color(0xffde1500),
                        buttonChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20.w,
                          children: [
                            SvgPicture.asset(
                              AppAssets.googleIconLogo,
                              width: 24.w,
                              height: 24.w,
                              colorFilter: ColorFilter.mode(
                                theme.scaffoldBackgroundColor,
                                BlendMode.srcIn,
                              ),
                              fit: BoxFit.scaleDown,
                            ),
                            Text(
                              loc.continueWithGoogleTitle,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: AppFonts.mainFontName,
                                color: theme.scaffoldBackgroundColor,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 600.ms)
                      .fadeIn(duration: 600.ms)
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
      ),
    );
  }
}
