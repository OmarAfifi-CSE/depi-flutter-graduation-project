import 'package:batrina/controllers/cubit/auth/verify_email_cubit/verify_email_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, required this.oobCode});

  final String oobCode;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => VerifyEmailCubit()
        ..loc = loc
        ..verifyEmail(oobCode: oobCode),
      child: Scaffold(
        body: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
          builder: (context, state) {
            if (state is VerifyEmailLoading || state is VerifyEmailInitial) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is VerifyEmailFailure) {
              return _buildStatusUI(
                context: context,
                theme: theme,
                loc: loc!,
                isSuccess: false,
                message: state.error,
              );
            }
            if (state is VerifyEmailSuccess) {
              return _buildStatusUI(
                context: context,
                theme: theme,
                loc: loc!,
                isSuccess: true,
              );
            }
            return const SizedBox.shrink(); // Should not happen
          },
        ),
      ),
    );
  }
}

Widget _buildStatusUI({
  required BuildContext context,
  required AppLocalizations loc,
  required ThemeData theme,
  required bool isSuccess,
  String? message,
}) {
  return SafeArea(
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child:
            Container(
                  padding: EdgeInsets.all(24.w),
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
                    children: [
                      Icon(
                        isSuccess
                            ? Icons.check_circle_outline_rounded
                            : Icons.error_outline_rounded,
                        color: isSuccess ? Colors.green : Colors.red,
                        size: 80.r,
                      ),
                      SizedBox(height: 30.h),
                      CustomText(
                        data: isSuccess
                            ? loc.emailVerifiedTitle
                            : loc.verificationFailedTitle,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 12.h),
                      CustomText(
                        data: isSuccess
                            ? loc.emailVerifiedSubtitle
                            : message ?? loc.defaultAuthErrorDescription,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 50.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () {
                            if (context.canPop()) context.pop();
                          },
                          buttonChild: CustomText(
                            data: isSuccess
                                ? loc.continueToSignInButton
                                : loc.backToSignInButton,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.2, curve: Curves.easeOut),
      ),
    ),
  );
}
