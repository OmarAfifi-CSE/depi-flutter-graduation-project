import 'package:batrina/controllers/cubit/verify_create_new_password_cubit/verify_create_new_password_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/auth/widgets/create_new_password.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key, required this.oobCode});

  final String oobCode;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) {
        return VerifyCreateNewPasswordCubit()
          ..loc = loc
          ..verifyCode(oobCode: oobCode);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                BlocBuilder<
                  VerifyCreateNewPasswordCubit,
                  VerifyCreateNewPasswordState
                >(
                  builder: (context, state) {
                    if (state is VerifyCreateNewPasswordLoading ||
                        state is VerifyCreateNewPasswordInitial) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: theme.scaffoldBackgroundColor,
                        ),
                      );
                    } else if (state is VerifyCreateNewPasswordFailure) {
                      return _buildErrorUI(context, loc, theme, state.error);
                    } else if (state is VerifyCreateNewPasswordSuccess) {
                      return CreateNewPassword(oobCode: oobCode);
                    }
                    return const Center(child: Text("Something went wrong."));
                  },
                ),
          ),
        ),
      ),
    );
  }
}

Widget _buildErrorUI(
  BuildContext context,
  AppLocalizations? loc,
  ThemeData theme,
  String error,
) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 60.r),
              SizedBox(height: 20.h),
              CustomText(
                data: error,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 40.h),
              CustomElevatedButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                buttonChild: CustomText(
                  data: "Close",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).animate()
      .fadeIn(duration: 500.ms)
      .slideY(begin: 0.2, curve: Curves.easeOut);
}
