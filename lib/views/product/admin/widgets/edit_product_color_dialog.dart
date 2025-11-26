import 'dart:convert';

import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/admin/widgets/adding_option.dart';
import 'package:batrina/views/product/admin/widgets/color_circle.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class EditProductColorDialog extends StatefulWidget {
  const EditProductColorDialog({
    super.key,
    required this.productColor,
    required this.index,
  });
  final ProductColor productColor;
  final int index;

  @override
  State<EditProductColorDialog> createState() => _EditProductColorDialogState();
}

class _EditProductColorDialogState extends State<EditProductColorDialog> {
  late List<String> images;
  late Color currentColor;
  @override
  void initState() {
    images = List.from(widget.productColor.images);
    currentColor = widget.productColor.color;
    super.initState();
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  void _openColorPicker(Color color) async {
    FocusScope.of(context).unfocus();

    final loc = AppLocalizations.of(context);

    final Color? result = await showDialog<Color>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        Color tempColor = color;
        return AlertDialog(
          actions: [
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(tempColor);
              },
              buttonChild: CustomText(
                data: loc!.select,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: theme.scaffoldBackgroundColor,
              ),
            ),
          ],
          contentPadding: EdgeInsets.all(12.r),
          backgroundColor: theme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12.r),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerAreaHeightPercent: 0.9,
              pickerAreaBorderRadius: BorderRadius.all(Radius.circular(10.r)),

              enableAlpha: false,
              displayThumbColor: true,
              showLabel: false,
              portraitOnly: true,
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
            ),
          ),
        );
      },
    );
    print(result);
    if (result != null) {
      setState(() {
        currentColor = result;
      });
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();
    return Container(
      height: 1.sh / 2,
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      child: Column(
        children: [
          Expanded(
            child: ReorderableGridView.count(
              footer: [AddingOption(images: images, refresh: refresh)],
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 1,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  final element = images.removeAt(oldIndex);
                  images.insert(newIndex, element);
                });
              },
              dragEnabled: true,
              children: images.map((img) {
                return Stack(
                  key: ValueKey(img),

                  children: [
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      clipBehavior: Clip.antiAlias, // This is the key property
                      child: BuildDynamicImage(imageUrl: img),
                    ),
                    Positioned(
                      top: 5.h,
                      right: 5.w,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            images.remove(img);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: .8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: theme.scaffoldBackgroundColor,
                            size: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(right: 8.0.w),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: () {
                  _openColorPicker(currentColor);
                },
                child: ColorCircle(productColor: currentColor),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonChild: CustomText(
                  data: loc!.cancel,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.primaryColor,
                ),
                backgroundColor: theme.scaffoldBackgroundColor,
                extend: true,
              ),
              CustomElevatedButton(
                onPressed:
                    jsonEncode(images) ==
                            jsonEncode(widget.productColor.images) &&
                        colorToHex(currentColor) ==
                            widget.productColor.colorCode
                    ? null
                    : () {
                        productFormProvider.updateProductColor(
                          widget.index,
                          ProductColor(
                            colorCode: colorToHex(currentColor),
                            images: images,
                          ),
                        );
                        Navigator.pop(context);
                      },
                buttonChild: CustomText(
                  data: loc.save,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.scaffoldBackgroundColor,
                ),
                backgroundColor: theme.primaryColor,
                extend: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
