import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/product/admin/widgets/variant_container.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VariantSelector extends StatelessWidget {
  const VariantSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final ProductFormProvider productFormProvider = context
        .watch<ProductFormProvider>();
    final colors = productFormProvider.product.availableColors;
    if (colors.isEmpty) {
      return Center(
        child: CustomText(
          data: loc!.pleaseAddColorsFirst,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              data: loc!.manageStockAndSizes,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: theme.scaffoldBackgroundColor,
                menuWidth: 150.w,
                value: productFormProvider.selectedVariantType,
                borderRadius: BorderRadius.circular(12.r),
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 12.sp,
                  fontFamily: AppFonts.englishFontFamily,
                ),
                alignment: AlignmentGeometry.center,
                items: productFormProvider.variantTypes
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
                  productFormProvider.setType(value!);
                  productFormProvider.clearAllVariants();
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        ...colors.map((color) {
          return VariantContainer(color: color);
        }).toList(),
      ],
    );
  }
}
