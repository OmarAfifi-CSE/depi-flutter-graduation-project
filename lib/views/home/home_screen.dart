import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/home/widgets/category_filter.dart'
    show FilterListView;
import 'package:batrina/views/home/widgets/home_carousel.dart'
    show HomeCarousel;
import 'package:batrina/views/home/widgets/product_grid_view.dart'
    show ProductGridView;
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Dresses';

  final List<String> categories = [
    'Dresses',
    'Jackets',
    'Jeans',
    'Shoes',
    'Accessories',
    'Bags',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              const HomeCarousel(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    CustomText(
                      data: loc!.categories,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 15.h),
                    FilterListView(
                      filters: categories,
                      initialSelection: 'Dresses',
                      onFilterSelected: (filter) {
                        setState(() {
                          selectedCategory = filter;
                        });
                      },
                      selectedColor: Colors.black,
                      unselectedColor: Colors.white,
                      selectedTextColor: Colors.white,
                      unselectedTextColor: Colors.black87,
                    ),
                    SizedBox(height: 15.h),
                    CustomText(
                      data: loc.top_dresses,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: const ProductGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
