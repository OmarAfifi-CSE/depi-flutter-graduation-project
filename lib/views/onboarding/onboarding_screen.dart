import 'package:flutter/material.dart';
import '../../styling/app_colors.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:batrina/views/onboarding/widgets/moving_arrow.dart';
import 'package:batrina/views/onboarding/widgets/custom_onboarding_page.dart';


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
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 10.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: appColors.card!,
                        activeDotColor: theme.primaryColor,
                      ),
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
