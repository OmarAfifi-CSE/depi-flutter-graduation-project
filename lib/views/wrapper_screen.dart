import 'package:batrina/widgets/custom_nav_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const List<String> _pageTitles = [
    'Home',
    'Wishlist',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          data: _pageTitles[navigationShell.currentIndex],
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: navigationShell
          .animate(key: ValueKey(navigationShell.currentIndex))
          .fadeIn(duration: 500.ms, curve: Curves.easeInOut)
          .slideY(begin: 1, end: 0, duration: 500.ms, curve: Curves.easeInOut),
      bottomNavigationBar: CustomNavBar(navigationShell: navigationShell),
    );
  }
}
