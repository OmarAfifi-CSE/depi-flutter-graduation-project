import 'package:batrina/controllers/cubit/auth/forget_password_cubit/forget_password__cubit.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text_form_field.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController emailCont = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String themeName(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? "dark" : "light";
  }

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
    return BlocProvider(
      create: (context) => ForgetPasswordCubit()..loc = loc,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                        Form(
                          key: _formKey,
                          child: Hero(
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
                        ),
                        SizedBox(height: 30.h),
                        BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                              listener: (context, state) {
                                if (state is ForgetPasswordFailure) {
                                  CustomSnackBar.showSnackBar(
                                    context: context,
                                    message: state.error,
                                    color: Colors.red,
                                  );
                                } else if (state is ForgetPasswordSuccess) {
                                  CustomSnackBar.showSnackBar(
                                    context: context,
                                    message: loc.forget_password_sent,
                                    color: Colors.green,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return CustomElevatedButton(
                                  onPressed: state is! ForgetPasswordLoading
                                      ? () async {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<ForgetPasswordCubit>()
                                                .forgetPass(
                                                  email: emailCont.text.trim(),
                                                  lang: Localizations.localeOf(
                                                    context,
                                                  ).languageCode,
                                                  themeModeName: themeName(
                                                    context,
                                                  ),
                                                );
                                          }
                                        }
                                      : () {},
                                  buttonChild: state is! ForgetPasswordLoading
                                      ? CustomText(
                                          data: loc.sendInstruction,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: theme.scaffoldBackgroundColor,
                                        )
                                      : CupertinoActivityIndicator(
                                          color: theme.scaffoldBackgroundColor,
                                        ),
                                );
                              },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
