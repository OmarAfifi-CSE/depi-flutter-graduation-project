import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/l10n/app_localizations.dart';

class ColorOption extends StatefulWidget {
  const ColorOption({super.key, required this.colors});

  final List<ProductColor> colors;

  @override
  State<ColorOption> createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  int selected = 0;

  @override
  void initState() {
    ProductProvider productProvider = context.read<ProductProvider>();
    selected = widget.colors.indexWhere(
      (element) => element.colorCode == productProvider.currentColorName,
    );
    if (selected == -1) {
      selected = 0;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();

    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);

    // Colors for LIGHT product variants
    const Color lightCheckmark = Colors.black87;
    final Color lightBorder = Colors.black.withValues(alpha: 0.2);
    final Color lightShadow = Colors.black.withValues(alpha: 0.15);

    // Colors for DARK product variants
    const Color darkCheckmark = Colors.white;
    final Color darkBorder = Colors.white.withValues(alpha: 0.3);
    final Color darkShadow = Colors.black.withValues(alpha: 0.2);

    return productProvider.currentColorName != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: .3),
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: List.generate(widget.colors.length, (index) {
                  final productColor = widget.colors[index].color;
                  // Check its luminance (0.0 = black, 1.0 = white)
                  final bool isLightColor =
                      productColor.computeLuminance() > 0.5;

                  final Color checkmarkColor = isLightColor
                      ? lightCheckmark
                      : darkCheckmark;
                  final Color borderColor = isLightColor
                      ? lightBorder
                      : darkBorder;
                  final Color shadowColor = isLightColor
                      ? lightShadow
                      : darkShadow;
                  return GestureDetector(
                    onTap: () {
                      selected = index;
                      context.read<ProductProvider>().setVariantStock(
                        colorCode: widget.colors[index].colorCode,
                        sizeName: productProvider.currentSize,
                      );
                      context.read<ProductProvider>().setSliderImage(
                        widget.colors[index].colorCode,
                      );
                    },
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: productColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 1.w),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: selected == index
                            ? Icon(
                                Icons.check,
                                color: checkmarkColor,
                                size: 14.sp,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        : CustomText(
            data: loc!.noAvailableColors,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: appColors.secondaryText,
          );
  }
}
