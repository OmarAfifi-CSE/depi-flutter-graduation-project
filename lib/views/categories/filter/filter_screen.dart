import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/categories/filter/widgets/category_chip.dart';
import 'package:batrina/views/categories/filter/widgets/price_slider.dart';
import 'package:batrina/views/categories/filter/widgets/rate_selection.dart';
import 'package:batrina/views/categories/filter/widgets/sortby_options.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FilterProvider>(context, listen: false)..fetchCategories();
    });
  }
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final filter = Provider.of<FilterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomHeaderWidget(prefix: BackArrow()),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    CustomText(
                      data: loc!.categories,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 15.h),
                    const CategoryChip(),
                    SizedBox(height: 30.h),
                    CustomText(
                      data: loc.priceRange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 15.h),
                    const PriceSlider(),
                    SizedBox(height: 30.h),

                    CustomText(
                      data: loc.sortBy,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 15),
                    const SortByOptions(),
                    const SizedBox(height: 30),

                    CustomText(
                      data: loc.ratting,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 15),
                    const RateSelection(),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: CustomElevatedButton(
                          onPressed: () {
                            final filter = Provider.of<FilterProvider>(
                              context,
                              listen: false,
                            );
                            context.pushNamed(AppRoutes.filteredProductsScreen);
                          },
                          buttonChild: Text(loc.applyNow),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
