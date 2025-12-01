import 'package:batrina/controllers/cubit/auth/auth_cubit/auth_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, required this.validation});

  final VoidCallback validation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignInFailure) {
              CustomSnackBar.showSnackBar(
                context: context,
                message: state.message,
                color: Colors.red,
              );
            } else if (state is AuthSignInSuccess) {
              CustomSnackBar.showSnackBar(
                context: context,
                message: loc!.signin_success,
                color: Colors.green,
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              onPressed: validation,
              buttonChild: state is! AuthSignInLoading
                  ? CustomText(
                      data: loc!.loginTitle,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      forceStrutHeight: true,
                      color: theme.scaffoldBackgroundColor,
                    )
                  : CupertinoActivityIndicator(
                      color: theme.scaffoldBackgroundColor,
                    ),
            );
          },
        )
        .animate(delay: 500.ms)
        .fadeIn(duration: 500.ms)
        .scale(
          duration: 1000.ms,
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
        )
        .shimmer(duration: 500.ms);
  }
}
