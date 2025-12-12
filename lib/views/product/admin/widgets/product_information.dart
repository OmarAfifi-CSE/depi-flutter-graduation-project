import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/product/admin/widgets/change_thumbnail.dart';
import 'package:batrina/views/product/admin/widgets/information_text_field.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInformation extends StatefulWidget {
  const ProductInformation({Key? key}) : super(key: key);

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  String? _validateName(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return loc!.productNameRequired;
    }
    if (value.length < 3) {
      return loc!.productNameMinLength;
    }
    return null;
  }

  String? _validateSubtitle(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return loc!.subtitleRequired;
    }
    if (value.length < 2) {
      return loc!.subtitleMinLength;
    }
    return null;
  }

  String? _validateDescription(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return loc!.descriptionRequired;
    }
    if (value.length < 10) {
      return loc!.descriptionMinLength;
    }
    return null;
  }

  String? _validatePrice(String? value) {
    final loc = AppLocalizations.of(context);
    if (value == null || value.isEmpty) {
      return loc!.priceRequired;
    }
    final price = double.tryParse(value);
    if (price == null) {
      return loc!.pleaseEnterValidPrice;
    }
    if (price <= 0) {
      return loc!.priceGreaterThanZero;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ProductFormProvider productFormProvider = context
        .watch<ProductFormProvider>();
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChangeThumbnail(),
        SizedBox(height: 10.h),

        Row(
          children: [
            Expanded(
              child: InformationTextField(
                textEditingController: productFormProvider.name,
                validator: _validateName,
                hint: loc!.enterProductName,
                title: loc.name,
                onChanges: (value) => productFormProvider.setName(value!),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: InformationTextField(
                textEditingController: productFormProvider.subtitle,
                validator: _validateSubtitle,
                hint: loc.enterSubTitle,
                title: loc.subTitle,
                onChanges: (value) => productFormProvider.setSubtitle(value!),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        InformationTextField(
          textEditingController: productFormProvider.description,
          validator: _validateDescription,
          hint: loc.enterDescription,
          title: loc.description,
          onChanges: (value) => productFormProvider.setDescription(value!),
          isEmail: true,
        ),
        SizedBox(height: 10.h),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: InformationTextField(
                textEditingController: productFormProvider.price,
                validator: _validatePrice,
                hint: loc.enterPrice,
                title: loc.price,
                onChanges: (value) => productFormProvider.setPrice(value!),
              ),
            ),
            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    data: loc.category,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),

                  BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: theme.primaryColor,
                          ),
                        );
                      } else if (state is CategoryError) {
                        return Center(
                          child: CustomText(
                            data: loc.errorFetchingCategories,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: theme.primaryColor,
                          ),
                        );
                      }

                      List<String> categories = (state as CategorySuccess)
                          .categories
                          .map((e) => e.name)
                          .toSet()
                          .toList();

                      String? selectedCategory =
                          productFormProvider.product.categoryName;

                      if (selectedCategory.isEmpty ||
                          !categories.contains(selectedCategory)) {
                        selectedCategory = null;
                      }
                      return DropdownButton<String>(
                        isExpanded: true,
                        dropdownColor: theme.scaffoldBackgroundColor,
                        menuWidth: 150.w,
                        value: selectedCategory,
                        borderRadius: BorderRadius.circular(12.r),
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 12.sp,
                          fontFamily: AppFonts.mainFontName,
                        ),
                        alignment: AlignmentGeometry.center,
                        items: categories
                            .map(
                              (s) => DropdownMenuItem(
                                value: s,
                                child: CustomText(
                                  data: s,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          productFormProvider.setCategory(value!);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
