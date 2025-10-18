import 'package:batrina/styling/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      color: theme.primaryColor,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          context.pop();
        },
        child: Container(
          width: 35.w,
          height: 35.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.arrowBack,
              width: 18.w,
              height: 12.h,
              colorFilter: ColorFilter.mode(
                theme.scaffoldBackgroundColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
