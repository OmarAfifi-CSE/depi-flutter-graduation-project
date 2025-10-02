import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorOption extends StatefulWidget {
  const ColorOption({super.key, required this.colors});

  final List<ProductColor> colors;

  @override
  State<ColorOption> createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();

    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return productProvider.currentColorName != null
        ? Container(
            // height: 41.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: .15),
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0.w, vertical: 11.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: List.generate(widget.colors.length, (index) {
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
                        border: Border.all(
                          color: widget.colors[index].colorCode == "#FFFFFF"
                              ? appColors.containerBorder!
                              : Colors.transparent,
                        ),
                        color: widget.colors[index].color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: selected == index
                            ? Icon(
                                Icons.check,
                                color:
                                    widget.colors[index].colorCode != "#FFFFFF"
                                    ? theme.scaffoldBackgroundColor
                                    : appColors.containerBorder,
                                size: 13.sp,
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
            data: "No available Colors",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: appColors.secondaryText,
          );
  }
}
