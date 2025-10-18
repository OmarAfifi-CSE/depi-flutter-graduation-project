import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';

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

  // --- 1. CENTRALIZED DIMENSIONS ---
  final double _iconSize = 22.w;
  late final double _unselectedContainerSize;
  late final double _selectedContainerSize;
  late final double _backgroundHeight;

  // --- State variables for animation ---
  late double _containerWidth;
  late double _backgroundWidth;
  late double _containerHeight;

  bool _isInitialSetupDone = false;

  @override
  void initState() {
    super.initState();

    _unselectedContainerSize = _iconSize;
    _selectedContainerSize = _iconSize + 12.w;
    _backgroundHeight = _selectedContainerSize;

    _containerWidth = _unselectedContainerSize;
    _containerHeight = _unselectedContainerSize;
    _backgroundWidth = 0.0;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialSetupDone && widget.isSelected) {
      _setSelectedState(context);
      _isInitialSetupDone = true;
    }
  }

  double _calculateTextWidth(BuildContext context, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.mainFontName,
        ),
      ),
      textDirection: Directionality.of(context),
      maxLines: 1,
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    final double iconWidth = _selectedContainerSize;
    final double leftPadding = 14.w;
    final double rightPadding = 14.w;
    final double textWidth = textPainter.width;
    final double safetyMargin = 2.w;

    return iconWidth + leftPadding + textWidth + rightPadding + safetyMargin;
  }

  @override
  void didUpdateWidget(CustomNavBarIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animateToSelected(context);
      } else {
        _animateToUnselected();
      }
    } else if (widget.isSelected && widget.name != oldWidget.name) {
      setState(() {
        _backgroundWidth = _calculateTextWidth(context, widget.name);
      });
    }
  }

  void _setSelectedState(BuildContext context) {
    _containerWidth = _selectedContainerSize;
    _containerHeight = _selectedContainerSize;
    _backgroundWidth = _calculateTextWidth(context, widget.name);
    _animationController.value = 1.0;
  }

  void _animateToSelected(BuildContext context) async {
    CustomNavBarIcon.isAnimating = true;
    setState(() {
      _containerWidth = _selectedContainerSize;
      _containerHeight = _selectedContainerSize;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        _backgroundWidth = _calculateTextWidth(context, widget.name);
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
        _containerWidth = _unselectedContainerSize;
        _containerHeight = _unselectedContainerSize;
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
        alignment: AlignmentDirectional.centerStart,
        children: [
          // Background container with text
          AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            opacity: _backgroundWidth == 0 ? 0 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _backgroundWidth,
              height: _backgroundHeight,
              padding: EdgeInsetsDirectional.only(
                start: _selectedContainerSize + 6.w,
                end: 6.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: appColors?.card ?? theme.cardColor,
              ),
              child: Center(
                child: AnimatedBuilder(
                  animation: _textAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textAnimation.value,
                      child: CustomText(
                        data: widget.name,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
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
                      width: _iconSize,
                      height: _iconSize,
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
