import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/onboarding/widgets/custom_onboarding_page.dart';
import 'package:batrina/views/onboarding/widgets/moving_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0.w),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomOnboardingPage(
                      image: AppAssets.onboarding1,
                      title: loc!.discountNewArrivalTitle,
                      subTitle: loc.discountNewArrivalDescription,
                    ),
                    CustomOnboardingPage(
                      image: AppAssets.onboarding2,
                      title: loc.takeAdvantageShoppingTitle,
                      subTitle: loc.takeAdvantageShoppingDescription,
                    ),
                    CustomOnboardingPage(
                      image: AppAssets.onboarding3,
                      title: loc.allTypesOffersTitle,
                      subTitle: loc.allTypesOffersDescription,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 10.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: appColors.dividerColor!,
                        activeDotColor: theme.primaryColor,
                      ),
                      onDotClicked: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    const Spacer(),
                    MovingArrow(pageController: _pageController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
