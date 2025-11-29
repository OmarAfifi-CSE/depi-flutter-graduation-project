import 'package:batrina/controllers/cubit/admin/admin_mode/admin_mode_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_nav_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          title: BlocBuilder<AdminModeCubit, bool>(
            builder: (context, state) {
              bool isAdmin = state;
              return CustomHeaderWidget(
                center: CustomText(
                  data: pageTitles[navigationShell.currentIndex],
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                suffix: isAdmin && navigationShell.currentIndex == 0
                    ? GestureDetector(
                        onTap: () =>
                            context.pushNamed(AppRoutes.editProductScreen),
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.5),
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 20.sp,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      )
                    : null,
              );
            },
          ),
        ),
        body: SafeArea(
          child: navigationShell
              .animate(key: ValueKey(navigationShell.currentIndex))
              .fadeIn(begin: 0.3, duration: 400.ms, curve: Curves.easeInOut),
        ),
        bottomNavigationBar: CustomNavBar(navigationShell: navigationShell),
      ),
    );
  }
}
