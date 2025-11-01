import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/home/widgets/category_filter.dart';
import 'package:batrina/views/home/widgets/home_carousel.dart';
import 'package:batrina/widgets/product/product_grid_view.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<String> _selectedCategoryNotifier = ValueNotifier('');
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductsProvider>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_selectedCategoryNotifier.value.isNotEmpty) {
          provider.fetchProducts(_selectedCategoryNotifier.value);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _selectedCategoryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..fetchCategories(),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeCarousel(),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: CustomText(
                        data: "Categories",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFonts.englishFontFamily,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CategoryFilter(
                      selectedCategoryNotifier: _selectedCategoryNotifier,
                    ),
                    SizedBox(height: 24.h),
                    ValueListenableBuilder<String>(
                      valueListenable: _selectedCategoryNotifier,
                      builder: (context, selectedCategory, child) {
                        if (selectedCategory.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 25.w),
                              child: CustomText(
                                data: 'Top in $selectedCategory',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppFonts.englishFontFamily,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ProductGridView(categoryName: selectedCategory),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
