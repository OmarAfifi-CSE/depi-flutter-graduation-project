import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/number_localizer.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/product/admin/widgets/add_variant_option.dart';
import 'package:batrina/views/product/admin/widgets/color_circle.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VariantContainer extends StatefulWidget {
  const VariantContainer({super.key, required this.color});

  final ProductColor color;

  @override
  State<VariantContainer> createState() => _VariantContainerState();
}

class _VariantContainerState extends State<VariantContainer> {
  final TextEditingController quantityController = TextEditingController(
    text: '1',
  );

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  void openAddVariantModal() {
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();

    productFormProvider.availableSizesForVariantType;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: productFormProvider,
          child: AddVariantOption(colorCode: widget.color.colorCode),
        );
      },
    );
  }

  void openEditVariantModel(ProductVariant prV) {
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();

    productFormProvider.availableSizesForVariantType;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: productFormProvider,
          child: AddVariantOption(
            colorCode: widget.color.colorCode,
            productVariant: prV,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductFormProvider productFormProvider = context
        .watch<ProductFormProvider>();
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorTheme>()!;

    List<ProductVariant> productVariants = productFormProvider
        .getVariantsForColor(widget.color.colorCode);
    final loc = AppLocalizations.of(context);
    final localeCode = Localizations.localeOf(context).languageCode;

    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: .15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadiusGeometry.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ColorCircle(productColor: widget.color.color),
                  SizedBox(width: 10.w),
                  CustomText(
                    data: loc!.sizesAndStock,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              CustomElevatedButton(
                onPressed:
                    (productVariants.length == 1 &&
                        productFormProvider.selectedVariantType == "Standard")
                    ? null
                    : openAddVariantModal,
                extend: true,
                buttonChild: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: theme.scaffoldBackgroundColor,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      data: loc.add,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.scaffoldBackgroundColor,
                      forceStrutHeight: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Divider(color: appColors.dividerColor, height: 20.h),

          if (productVariants.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CustomText(
                  fontWeight: FontWeight.w500,
                  data: loc.noSizesAdded,
                  fontSize: 12.sp,
                  color: appColors.secondaryText,
                ),
              ),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: productVariants.map((variant) {
                return GestureDetector(
                  onTap: () {
                    openEditVariantModel(variant);
                  },
                  child: Chip(
                    backgroundColor: theme.cardColor,
                    side: BorderSide(color: appColors.dividerColor!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          data: variant.size.toString(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.englishFontFamily,
                        ),
                        CustomText(
                          data:
                              "(${NumberLocalizer.formatNumber(variant.stock, localeCode)})",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.secondaryText,
                        ),
                      ],
                    ),
                    deleteIcon: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: Colors.red,
                    ),
                    onDeleted: () {
                      productFormProvider.removeVariant(
                        variant.color,
                        variant.size,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
