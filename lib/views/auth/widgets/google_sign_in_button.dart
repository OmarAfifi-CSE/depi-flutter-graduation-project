import 'package:batrina/controllers/cubit/auth/auth_cubit/auth_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthGoogleFailure) {
              context.pop();
              CustomSnackBar.showSnackBar(
                context: context,
                message: state.message,
                color: Colors.red,
              );
            } else if (state is AuthGoogleSuccess) {
              context.pop();
              CustomSnackBar.showSnackBar(
                context: context,
                message: loc!.signin_success,
                color: Colors.green,
              );
            } else if (state is AuthGoogleLoading) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    backgroundColor: Colors.white70,
                    content: SizedBox(
                      height: 150.h,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              onPressed: context.read<AuthCubit>().signInWithGoogle,
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
                    loc!.continueWithGoogleTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: AppFonts.mainFontName,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                ],
              ),
            );
          },
        )
        .animate(delay: 600.ms)
        .fadeIn(duration: 600.ms)
        .scale(
          duration: 1000.ms,
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
        )
        .shimmer(duration: 500.ms);
  }
}
