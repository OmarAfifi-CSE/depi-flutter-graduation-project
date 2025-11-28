import 'package:batrina/controllers/provider/deep_link_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const SplashScreen({super.key, required this.sharedPreferences});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // A small delay can prevent a jarring flicker on fast devices
    await Future.delayed(const Duration(milliseconds: 800));

    // First, always check if onboarding has been completed
    final bool isOnboardingComplete =
        widget.sharedPreferences.getBool('onboardingComplete') ?? false;
    if (!isOnboardingComplete) {
      // If not, go to onboarding and stop the rest of the logic
      if (mounted) context.go(AppRoutes.onboardingScreen);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    // Check if a user is logged into Firebase Auth and their email is verified
    if (user != null && user.emailVerified) {
      try {
        final firestoreService = FireBaseFireStore();
        final userModel = await firestoreService.getUserData(user.uid);

        // Set the static variable so it's available across the app
        FireBaseFireStore.currentUser = userModel;

        // Now that the user data is ready, navigate to the main app screen
        DeepLinkProvider deepLinkProvider = context.read<DeepLinkProvider>();
        final deepLink = deepLinkProvider.consumeDeepLink();
        if (deepLink != null) {
          if (mounted) context.go(AppRoutes.wrapperScreen);
          context.pushNamed(
            AppRoutes.productScreen,
            pathParameters: {'productId': deepLink},
          );
        } else {
          if (mounted) context.go(AppRoutes.wrapperScreen);
        }
      } catch (e) {
        print(e.toString());
        // Handle a rare error where user is in Auth but not Firestore
        await FirebaseAuth.instance.signOut();
        if (mounted) context.go(AppRoutes.signInScreen);
      }
    } else {
      // If no user is logged in or their email is not verified, go to the sign-in screen
      if (mounted) context.go(AppRoutes.signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: Text(
              'Batrina.',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: 42.sp,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.englishFontFamily,
              ),
            ).animate().fade(delay: 200.ms, duration: 400.ms),
          ),
          // 2. The Left "Door"
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: screenWidth / 2,
              height: double.infinity,
              color: theme.scaffoldBackgroundColor,
            ),
          ).animate().slideX(
            begin: 0,
            end: -1,
            duration: 800.ms,
            delay: 300.ms,
            curve: Curves.easeInOutCubic,
          ),
          // 3. The Right "Door"
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screenWidth / 2,
              height: double.infinity,
              color: theme.scaffoldBackgroundColor,
            ),
          ).animate().slideX(
            begin: 0,
            end: 1,
            duration: 800.ms,
            delay: 300.ms,
            curve: Curves.easeInOutCubic,
          ),
        ],
      ),
    );
  }
}
