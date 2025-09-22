import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styling/app_colors.dart';
import 'custom_text.dart';

class CustomNavBarIcon extends StatefulWidget {
  static bool isAnimating = false;
  const CustomNavBarIcon({
    super.key,
    required this.path,
    required this.name,
    required this.onTap,
    this.isSelected = false,
  });

  final String path;
  final String name;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  State<CustomNavBarIcon> createState() => CustomNavBarIconState();
}

class CustomNavBarIconState extends State<CustomNavBarIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _textAnimation;
  late Animation<double> _scaleAnimation;

  double _containerWidth = 16.0;
  double _backgroundWidth = 0.0;
  double _containerHeight = 16.0;

  double _calculateTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width + 72.w;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isSelected) {
      _setSelectedState();
    }
  }

  @override
  void didUpdateWidget(CustomNavBarIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animateToSelected();
      } else {
        _animateToUnselected();
      }
    }
  }

  void _setSelectedState() {
    _containerWidth = 30.w;
    _containerHeight = 30.h;
    _backgroundWidth = _calculateTextWidth(widget.name);
    _animationController.value = 1.0;
  }

  void _animateToSelected() async {
    CustomNavBarIcon.isAnimating = true;

    setState(() {
      _containerWidth = 30.w;
      _containerHeight = 30.h;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    if (mounted) {
      setState(() {
        _backgroundWidth = _calculateTextWidth(widget.name);
      });
    }

    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      await _animationController.forward();
    }

    CustomNavBarIcon.isAnimating = false;
  }

  void _animateToUnselected() async {
    CustomNavBarIcon.isAnimating = true;

    if (mounted) {
      await _animationController.reverse();
    }

    if (mounted) {
      setState(() {
        _backgroundWidth = 0.0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      setState(() {
        _containerWidth = 16.w;
        _containerHeight = 16.h;
      });
    }

    CustomNavBarIcon.isAnimating = false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>();

    return GestureDetector(
      onTap: () {
        if (!CustomNavBarIcon.isAnimating) {
          widget.onTap();
        }
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            opacity: _backgroundWidth == 0 ? 0 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _backgroundWidth,
              height: 30.h,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: appColors?.card ?? theme.cardColor,
              ),
              child: AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textAnimation.value,
                    child: CustomText(
                      data: widget.name,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  );
                },
              ),
            ),
          ),

          // Icon container
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.isSelected ? _scaleAnimation.value : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: _containerWidth,
                  height: _containerHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.isSelected
                        ? theme.primaryColor
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      widget.path,
                      width: 16.w,
                      height: 16.h,
                      colorFilter: ColorFilter.mode(
                        widget.isSelected
                            ? theme.scaffoldBackgroundColor
                            : theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
