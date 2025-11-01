import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/custom_nav_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    List<String> pageTitles = [
      loc!.home,
      loc.categories,
      loc.cart,
      loc.profile,
    ];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: CustomText(
            data: pageTitles[navigationShell.currentIndex],
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SafeArea(
          child: navigationShell
              .animate(key: ValueKey(navigationShell.currentIndex))
              .fadeIn(duration: 500.ms, curve: Curves.easeInOut)
              .slideY(
                begin: 1,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeInOut,
              ),
        ),
        bottomNavigationBar: CustomNavBar(navigationShell: navigationShell),
      ),
    );
  }
}
