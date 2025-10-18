import 'package:batrina/controllers/cubit/profile/edit_user_cubit/edit_user_cubit.dart';
import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_text.dart';
import '../../auth/widgets/custom_elevated_button.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
    required this.confirmFunction,
    required this.cubit,
  });
  final void Function() confirmFunction;

  final EditUserCubit cubit;
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = context.watch<ProfileProvider>();
    final theme = Theme.of(context);
    return BlocConsumer<EditUserCubit, EditUserState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is EditUserSuccess) {
          // CustomSnackBar.showSnackBar(
          //   context: context,
          //   message: "Edited successfully",
          //   color: Colors.green,
          // );
        } else if (state is EditUserFailure) {
          // CustomSnackBar.showSnackBar(
          //   context: context,
          //   message: state.error,
          //   color: Colors.red,
          // );
        }
      },
      builder: (context, state) {
        return profileProvider.showButton
            ? CustomElevatedButton(
                onPressed: state is! EditUserLoading ? confirmFunction : () {},
                buttonChild: state is! EditUserLoading
                    ? CustomText(
                        data: "Confirm",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: theme.scaffoldBackgroundColor,
                      )
                    : CupertinoActivityIndicator(
                        color: theme.scaffoldBackgroundColor,
                      ),
              ).animate().fadeIn(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              )
            : const SizedBox();
      },
    );
  }
}
