import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovingArrow extends StatelessWidget {
  const MovingArrow({super.key, required PageController pageCont})
    : _pageController = pageCont;
  final PageController _pageController;

  void _onTap() {
    if (_pageController.page! < 2) {
      _pageController.animateToPage(
        (_pageController.page! + 1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
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
