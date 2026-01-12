import 'package:batrina/controllers/cubit/auth/auth_cubit/auth_cubit.dart';
import 'package:batrina/controllers/provider/deep_link_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
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
              final deepLinkProvider = context.read<DeepLinkProvider>();
              final deepLink = deepLinkProvider.consumeDeepLink();
              if (deepLink != null) {
                if (context.mounted) context.go(AppRoutes.wrapperScreen);
                if (context.mounted) {
                  context.pushNamed(
                    AppRoutes.productScreen,
                    pathParameters: {'productId': deepLink},
                  );
                }
              } else {
                if (context.mounted) context.go(AppRoutes.wrapperScreen);
              }
            } else if (state is AuthGoogleLoading) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    backgroundColor: theme.primaryColor.withValues(alpha: 0.2),
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
            return OutlinedButton(
              onPressed: context.read<AuthCubit>().signInWithGoogle,
              style: OutlinedButton.styleFrom(
                backgroundColor: theme.scaffoldBackgroundColor,
                fixedSize: Size(325.w, 46.h),
                side: BorderSide(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.googleIconLogo,
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(width: 12.w),
                  CustomText(
                    data: loc!.continueWithGoogleTitle,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    forceStrutHeight: true,
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
