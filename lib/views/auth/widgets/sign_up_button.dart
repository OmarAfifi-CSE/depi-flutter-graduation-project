import 'package:batrina/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.validation});

  final VoidCallback validation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignUpFailure) {
              CustomSnackBar.showSnackBar(
                context: context,
                message: state.message,
                color: Colors.red,
              );
            } else if (state is AuthSignUpSuccess) {
              CustomSnackBar.showSnackBar(
                context: context,
                message: loc!.check_email_activation,
                color: Colors.green,
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              backgroundColor: theme.primaryColor,
              onPressed: validation,
              buttonChild: state is! AuthSignUpLoading
                  ? Text(
                      loc!.signUpTitle,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: AppFonts.mainFontName,
                        color: theme.scaffoldBackgroundColor,
                      ),
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
