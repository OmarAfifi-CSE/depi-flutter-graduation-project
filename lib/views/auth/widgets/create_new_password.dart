import 'package:batrina/controllers/cubit/create_new_password_cubit/create_new_password_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/views/auth/widgets/custom_text_form_field.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key, required this.oobCode});

  final String oobCode;

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

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
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 9.h),
        CustomHeaderWidget(
          prefix: const BackArrow(),
          center: CustomText(
            data: loc!.create_new_password,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 100.h),
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              SizedBox(height: 30.h),
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
        SizedBox(height: 30.h),

        BlocConsumer<CreateNewPasswordCubit, CreateNewPasswordState>(
              listener: (context, state) {
                if (state is CreateNewPasswordFailure) {
                  CustomSnackBar.showSnackBar(
                    context: context,
                    message: state.error,
                    color: Colors.red,
                  );
                } else if (state is CreateNewPasswordSuccess) {
                  CustomSnackBar.showSnackBar(
                    context: context,
                    message: loc.password_changed_success,
                    color: Colors.green,
                  );
                  context.pop();
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  onPressed: state is! CreateNewPasswordLoading
                      ? () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<CreateNewPasswordCubit>()
                                .createNewPassword(
                                  code: widget.oobCode,
                                  newPassword: confirmPasswordController.text
                                      .trim(),
                                );
                          }
                        }
                      : () {},
                  buttonChild: state is! CreateNewPasswordLoading
                      ? CustomText(
                          data: loc.confirm,
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
    );
  }
}
