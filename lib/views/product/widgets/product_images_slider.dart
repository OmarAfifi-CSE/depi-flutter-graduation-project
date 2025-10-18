import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/product/widgets/heart.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/product/build_dynamic_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  final PageController _pageController = PageController();

  void _moveRight() {
    if (!_pageController.hasClients || _pageController.page == null) return;
    if (_pageController.page! < 2) {
      _pageController.animateToPage(
        (_pageController.page! + 1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _moveLeft() {
    if (!_pageController.hasClients || _pageController.page == null) return;
    if (_pageController.page! != 0) {
      _pageController.animateToPage(
        (_pageController.page! + -1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: PageView(
            key: ValueKey(productProvider.currentColorName),
            controller: _pageController,
            children: List.generate(productProvider.currentSliderImage.length, (
              index,
            ) {
              return BuildDynamicImage(
                imageUrl: productProvider.currentSliderImage[index],
              );
            }),
          ),
        ),
        Positioned(left: 25.w, top: 35.h, child: const BackArrow()),
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: productProvider.currentSliderImage.length > 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _moveLeft,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: appColors.secondaryText,
                            size: 18.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: _moveRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: appColors.secondaryText,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 36.h,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: productProvider.currentSliderImage.length > 1
                ? SmoothPageIndicator(
                    controller: _pageController,
                    count: productProvider.currentSliderImage.length,
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
                    onDotClicked: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                : const SizedBox(),
          ),
        ),
        Positioned(
          right: 25.w,
          bottom: 38.h,
          child: Heart(productModel: widget.productModel),
        ),
      ],
    );
  }
}
