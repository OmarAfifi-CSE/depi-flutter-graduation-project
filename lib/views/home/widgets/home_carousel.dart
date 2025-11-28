import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/categories/widgets/category_card_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoryLoading() || CategoryInitial():
            return SizedBox(
              height: 180.h,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          case CategoryError():
            return SizedBox(
              height: 180.h,
              child: Center(
                child: CustomText(
                  data: loc.couldNotLoadCategories,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );

          case CategorySuccess():
            if (state.categories.isEmpty) {
              return SizedBox(
                height: 180.h,
                child: Center(
                  child: CustomText(
                    data: loc.emptyCategories,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return CarouselSlider(
              options: CarouselOptions(
                height: 180.h,
                viewportFraction: 0.8,
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: state.categories.map((category) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CategoryCardWidget(
                    category: category,
                    padding: EdgeInsets.zero,
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
