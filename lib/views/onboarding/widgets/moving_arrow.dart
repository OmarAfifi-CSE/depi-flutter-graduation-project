import 'package:batrina/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MovingArrow extends StatefulWidget {
  const MovingArrow({super.key, required PageController pageCont})
    : _pageController = pageCont;
  final PageController _pageController;

  @override
  State<MovingArrow> createState() => _MovingArrowState();
}

class _MovingArrowState extends State<MovingArrow> {
  void _onTap() {
    if (widget._pageController.page! < 2) {
      widget._pageController.animateToPage(
        (widget._pageController.page! + 1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (widget._pageController.page == 2) {
      context.pushReplacementNamed(AppRoutes.signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.primaryColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: _onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          //temp
          child: Icon(
            Icons.arrow_forward,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
