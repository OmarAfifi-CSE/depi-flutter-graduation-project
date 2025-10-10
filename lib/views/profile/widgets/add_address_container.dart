import 'package:animations/animations.dart';
import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/views/profile/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_text.dart';

class AddAddressContainer extends StatelessWidget {
  const AddAddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final addressesCubit = context.read<GetAddressesCubit>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (context, animation, secondaryAnimation) {
              return BlocProvider.value(
                value: addressesCubit,
                child: const AddAddressScreen(),
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                    transitionType: SharedAxisTransitionType.horizontal,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primaryColor,
              theme.primaryColor.withValues(alpha: 0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.3),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.scaffoldBackgroundColor.withValues(alpha: 0.15),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 32.sp,
                color: theme.scaffoldBackgroundColor,
              ),
            ),

            SizedBox(height: 12.h),
            CustomText(
              data: 'Add New Address',
              color: theme.scaffoldBackgroundColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),

            SizedBox(height: 4.h),
            CustomText(
              data: 'Tap to add',
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
