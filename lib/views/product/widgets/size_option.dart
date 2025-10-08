import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';
import '../../../styling/app_fonts.dart';

class SizeOption extends StatefulWidget {
  const SizeOption({super.key, required this.sizes});

  final List<String> sizes;

  @override
  State<SizeOption> createState() => _SizeOptionState();
}

class _SizeOptionState extends State<SizeOption> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);

    return productProvider.currentSize != null
        ? Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.generate(widget.sizes.length, (index) {
              return GestureDetector(
                onTap: () {
                  selected = index;
                  context.read<ProductProvider>().setVariantStock(
                    colorCode: productProvider.currentColorName,
                    sizeName: widget.sizes[index],
                  );
                },
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index != selected
                        ? theme.scaffoldBackgroundColor
                        : theme.primaryColor,
                    border: Border.all(color: appColors.containerBorder!),
                  ),
                  child: Center(
                    child: CustomText(
                      data: widget.sizes[index],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: index != selected
                          ? appColors.secondaryText
                          : theme.scaffoldBackgroundColor,
                      fontFamily: AppFonts.englishFontFamily,
                    ),
                  ),
                ),
              );
            }),
          )
        : CustomText(
            textAlign: TextAlign.start,
            data: loc!.noAvailableSizes,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: appColors.secondaryText,
          );
  }
}
