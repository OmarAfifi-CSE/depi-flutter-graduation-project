import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/onboarding/widgets/custom_onboarding_page.dart';
import 'package:batrina/views/onboarding/widgets/moving_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styling/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0.w),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    CustomOnboardingPage(
                      image:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIsKrMKEnxtEXBGdJltmzaTuA3nYmg07oygA&s",
                      title: loc!.discountNewArrivalTitle,
                      subTitle: loc.discountNewArrivalDescription,
                    ),
                    CustomOnboardingPage(
                      image:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIsKrMKEnxtEXBGdJltmzaTuA3nYmg07oygA&s",
                      title: loc.takeAdvantageShoppingTitle,
                      subTitle: loc.takeAdvantageShoppingDescription,
                    ),
                    CustomOnboardingPage(
                      image:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIsKrMKEnxtEXBGdJltmzaTuA3nYmg07oygA&s",
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
                      controller: _pageController, // PageController
                      count: 3,
                      effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 10.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: theme.colorScheme.primary,
                        activeDotColor: theme.primaryColor,
                      ), // your preferred effect
                      onDotClicked: (index) {},
                    ),
                    const Spacer(),
                    MovingArrow(pageCont: _pageController),
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
