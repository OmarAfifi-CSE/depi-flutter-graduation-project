import 'package:batrina/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovingArrow extends StatelessWidget {
  const MovingArrow({super.key, required this.pageController});

  final PageController pageController;

  Future<void> _setOnboardingComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardingComplete', true);
    } catch (e) {
      debugPrint("Mario :: Error saving onboarding status: $e");
    }
  }

  void _onTap(BuildContext context) {
    if (!pageController.hasClients || pageController.page == null) return;
    if (pageController.page! < 2) {
      pageController.animateToPage(
        (pageController.page! + 1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (pageController.page == 2) {
      _setOnboardingComplete().then((_) {
        if (context.mounted) {
          context.pushReplacementNamed(AppRoutes.signInScreen);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.primaryColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () => _onTap(context),
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
